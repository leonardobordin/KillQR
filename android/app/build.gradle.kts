plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.killstreak.killqr"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    val hasReleaseSigning = listOf(
        "killqrReleaseKeystore",
        "killqrReleaseStorePassword",
        "killqrReleaseKeyAlias",
        "killqrReleaseKeyPassword",
    ).all { providers.gradleProperty(it).isPresent }

    signingConfigs {
        if (hasReleaseSigning) {
            create("killqrRelease") {
                storeFile = file(providers.gradleProperty("killqrReleaseKeystore").get())
                storePassword = providers.gradleProperty("killqrReleaseStorePassword").get()
                keyAlias = providers.gradleProperty("killqrReleaseKeyAlias").get()
                keyPassword = providers.gradleProperty("killqrReleaseKeyPassword").get()
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.killstreak.killqr"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Local builds fall back to the debug key. The GitHub release
            // workflow supplies all four killqrRelease* properties from
            // repository secrets and uses the distribution key instead.
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("killqrRelease")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
