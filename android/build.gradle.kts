import org.jetbrains.kotlin.gradle.dsl.KotlinVersion
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    // Prebuilt deps now ship Kotlin 2.3 bytecode: google_maps_flutter_android
    // 2.19.8 pulls android-maps-utils 4.1.0, whose metadata is version 2.3.0. A
    // Kotlin compiler can only read metadata up to its own version, so the whole
    // project must compile on Kotlin 2.3.0 (set in settings.gradle.kts). Pin the
    // stdlib to that same version so no plugin drags in a newer one the compiler
    // can't read.
    configurations.all {
        resolutionStrategy {
            force("org.jetbrains.kotlin:kotlin-stdlib:2.3.0")
            force("org.jetbrains.kotlin:kotlin-stdlib-jdk7:2.3.0")
            force("org.jetbrains.kotlin:kotlin-stdlib-jdk8:2.3.0")
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Some older plugins (e.g. posthog_flutter) pin their Kotlin language/api
// version to 1.6, which the Kotlin 2.3 compiler no longer supports (min 2.0).
// configureEach is lazy (runs at task realization, after the plugin sets its
// value), so it overrides anything below 2.0 without needing afterEvaluate.
subprojects {
    tasks.withType<KotlinCompile>().configureEach {
        compilerOptions {
            val lv = languageVersion.orNull
            if (lv != null && lv < KotlinVersion.KOTLIN_2_0) {
                languageVersion.set(KotlinVersion.KOTLIN_2_0)
            }
            val av = apiVersion.orNull
            if (av != null && av < KotlinVersion.KOTLIN_2_0) {
                apiVersion.set(KotlinVersion.KOTLIN_2_0)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
