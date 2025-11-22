plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.habit_tracker"
    compileSdk = 35  // ✅ Fixed: explicitly set to 34
    ndkVersion = "27.0.12077973"  // ✅ Fixed: explicitly set NDK version

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11  // ✅ Changed from 11 to 8
        targetCompatibility = JavaVersion.VERSION_11  // ✅ Changed from 11 to 8
        isCoreLibraryDesugaringEnabled = true  // ✅ Added: required for notifications
    }

    kotlinOptions {
        jvmTarget = "11"  // ✅ Changed from 11 to 8
    }

    defaultConfig {
        applicationId = "com.example.habit_tracker"
        minSdk = 21  // ✅ Fixed: explicitly set to 21
        targetSdk = 35  // ✅ Fixed: explicitly set to 34
        versionCode = 1
        versionName = "1.0"
        multiDexEnabled = true  // ✅ Added: required for larger apps
    }

    buildTypes {
        release {
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Added: Core library desugaring for notifications
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
