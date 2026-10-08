# F-Droid preparation

This repository contains the `fdroid` product flavor, upstream store metadata,
and the proposed source-build steps. The actual catalog submission is a
separate merge request to `fdroiddata`.

## Current recipe inputs

- application ID: `com.killstreak.killqr`;
- version name/code: `0.1.10` / `11` (from `pubspec.yaml`);
- minimum Android API: 26;
- Flutter/Dart: 3.47.2 / 3.13.2;
- Gradle wrapper: 9.3.1;
- Android Gradle Plugin: 9.1.0;
- Kotlin: 2.4.0;
- NDK: 28.2.13676358;
- runtime manifest: camera plus legacy `WRITE_EXTERNAL_STORAGE` limited to
  `maxSdkVersion=28` for explicit gallery saves; the `fdroid` flavor omits
  `INTERNET` and the GitHub release checker;
- F-Droid build: `flutter build apk --release --flavor fdroid`;
- F-Droid output: `build/app/outputs/flutter-apk/app-fdroid-release.apk`.
- SQLite source: vendored SQLite 3.50.2 compiled from source by the Dart hook.

## Source build checks

An isolated builder should first populate the Flutter and Gradle caches from
approved source archives, then run:

```text
flutter pub get --offline
dart run build_runner build
flutter analyze
flutter test
flutter build apk --release --flavor fdroid
powershell -ExecutionPolicy Bypass -File scripts/audit_android.ps1 -ApkPath build/app/outputs/flutter-apk/app-fdroid-release.apk -ExpectedFlavor fdroid
powershell -ExecutionPolicy Bypass -File scripts/check_prohibited_dependencies.ps1
```

After copying the build block to a local `fdroiddata` checkout, validate it
with the F-Droid server tools:

```text
fdroid lint com.killstreak.killqr
fdroid build com.killstreak.killqr
```

The `sqlite3` package uses Dart native hooks configured to compile the vendored
SQLite source, rather than downloading its default precompiled release asset.
The isolated F-Droid build must still confirm this behavior from a clean
checkout.

## Metadata boundary

`metadata/com.killstreak.killqr.yml` is a ready copy of the build metadata to
add as `metadata/com.killstreak.killqr.yml` in the separate `fdroiddata`
repository. Its build block pins the full source commit for `v0.1.10`.
`fastlane/metadata/android` supplies the localized listing, icon, screenshots
and changelogs. The `fdroiddata` CI then validates the recipe.

No signing key or store token belongs in this repository.
