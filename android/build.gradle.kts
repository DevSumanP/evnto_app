import org.jetbrains.kotlin.gradle.dsl.KotlinVersion
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    // Some plugins (e.g. screen_brightness_android 2.1.5) drag in a newer
    // kotlin-stdlib than this project's Kotlin compiler (2.1.0). A 2.1 compiler
    // cannot read stdlib metadata newer than itself, so it crashes on the
    // metadata check. Pin the stdlib down to the compiler's version everywhere —
    // nothing here uses newer stdlib APIs anyway, so this is safe.
    configurations.all {
        resolutionStrategy {
            force("org.jetbrains.kotlin:kotlin-stdlib:2.1.0")
            force("org.jetbrains.kotlin:kotlin-stdlib-jdk7:2.1.0")
            force("org.jetbrains.kotlin:kotlin-stdlib-jdk8:2.1.0")
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
// version to 1.6, which the Kotlin 2.1 compiler no longer supports (min 2.0).
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
