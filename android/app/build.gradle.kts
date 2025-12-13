plugins {
    // Android application plugin
    id("com.android.application")

    // Kotlin support for Android
    id("kotlin-android")

    // Flutter Gradle plugin (must be after Android & Kotlin plugins)
    id("dev.flutter.flutter-gradle-plugin")

    // Google Services plugin (Firebase, Google login, etc.)
    id("com.google.gms.google-services")
}

android {
    // Application package name
    namespace = "com.example.pathshala"

    // Compile SDK version (comes from Flutter)
    compileSdk = flutter.compileSdkVersion

    // Native Development Kit version (Flutter-managed)
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Java 17 compatibility
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        // Kotlin JVM target = Java 17
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Unique application ID
        applicationId = "com.example.pathshala"

        // 🔥 IMPORTANT FIX:
        // Facebook SDK REQUIRES minSdkVersion 21
        // DO NOT use flutter.minSdkVersion (usually 19)
        minSdk = flutter.minSdkVersion

        // Target SDK version (from Flutter)
        targetSdk = flutter.targetSdkVersion

        // App version code
        versionCode = flutter.versionCode

        // App version name
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Using debug signing for now
            // Replace with your release keystore for Play Store
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Flutter source directory
flutter {
    source = "../.."
}
