import java.io.FileInputStream
import java.util.Properties
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// ---------------------------------------------------------------------------
// Release signing configuration.
//  Local builds : read android/key.properties (gitignored).
//  CI builds    : the workflow decodes the keystore and writes key.properties.
//  Not set      : fall back to debug signing so `flutter run --release` works.
// ---------------------------------------------------------------------------

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

// Google Maps key. Read from android/secrets.properties (gitignored) for local
// builds, or the MAPS_API_KEY env var for CI. Empty if neither is set.
val secretsProperties = Properties()
val secretsPropertiesFile = rootProject.file("secrets.properties")
if (secretsPropertiesFile.exists()) {
    secretsProperties.load(FileInputStream(secretsPropertiesFile))
}

android {
    namespace = "com.evnto.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    defaultConfig {
        applicationId = "com.evnto.app"
        // Override Flutter's default minSdk (21). flutter_nfc_kit requires
        // API 26+, which is the binding constraint. nearby_connections needs
        // 24+ and BLUETOOTH_SCAN with neverForLocation needs the API-31
        // toolchain, both already satisfied at 26.
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Inject the Google Maps key into AndroidManifest at build time.
        manifestPlaceholders["MAPS_API_KEY"] =
            secretsProperties.getProperty("MAPS_API_KEY")
                ?: System.getenv("MAPS_API_KEY") ?: ""
    }

    flavorDimensions += "flavor"
    productFlavors {
        create("development") {
            dimension = "flavor"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "Evnto Dev")
        }
        create("staging") {
            dimension = "flavor"
            // No applicationIdSuffix: staging shares com.evnto.app with production
            // so it rides the production Play app's internal testing track.
            resValue("string", "app_name", "Evnto Staging")
        }
        create("production") {
            dimension = "flavor"
            resValue("string", "app_name", "Evnto")
        }
    }

    signingConfigs {
        create("release") {
            // storeFile path is resolved relative to android/app/.
            val storeFilePath = keystoreProperties.getProperty("storeFile")
                ?: System.getenv("ANDROID_KEYSTORE_PATH")
            if (storeFilePath != null) {
                storeFile = file(storeFilePath)
                storePassword = keystoreProperties.getProperty("storePassword")
                    ?: System.getenv("ANDROID_KEYSTORE_PASSWORD")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                    ?: System.getenv("ANDROID_KEY_ALIAS")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                    ?: System.getenv("ANDROID_KEY_PASSWORD")
            }
        }
    }

    buildTypes {
        release {
            val releaseConfig = signingConfigs.getByName("release")
            signingConfig = if (releaseConfig.storeFile != null) {
                releaseConfig
            } else {
                signingConfigs.getByName("debug")
            }

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

// Kotlin 2.x replaced the kotlinOptions {} DSL with compilerOptions {}.
kotlin {
    compilerOptions {
        jvmTarget = JvmTarget.JVM_11
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
