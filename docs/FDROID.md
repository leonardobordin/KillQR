# F-Droid preparation

This repository contains the source-build notes and a deliberately incomplete
metadata draft. It is not a submission and it does not publish anything.

## Current recipe inputs

- application ID: `com.killstreak.killqr`;
- version name/code: `0.1.6` / `7`;
- minimum Android API: 26;
- Flutter/Dart: 3.47.2 / 3.13.2;
- Gradle wrapper: 9.3.1;
- Android Gradle Plugin: 9.1.0;
- Kotlin: 2.4.0;
- NDK: 28.2.13676358;
- runtime manifest: camera plus legacy `WRITE_EXTERNAL_STORAGE` limited to
  `maxSdkVersion=28` for explicit gallery saves; optional `INTERNET` only for
  the user-controlled GitHub release checker;
- release output: `build/app/outputs/flutter-apk/app-release.apk`.

## Source build checks

An isolated builder should first populate the Flutter and Gradle caches from
approved source archives, then run:

```text
flutter pub get --offline
dart run build_runner build
flutter analyze
flutter test
flutter build apk --release
powershell -ExecutionPolicy Bypass -File scripts/audit_android.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_prohibited_dependencies.ps1
```

The `sqlite3` package uses Dart native hooks. The final F-Droid recipe must
confirm that the hook builds SQLite from accepted source inputs and does not
fetch or execute an opaque prebuilt artifact. That check cannot be claimed by
the local Flutter cache alone.

## Metadata boundary

`metadata/com.killstreak.killqr.yml` records the verifiable application
metadata but intentionally omits `Repo` and an immutable `commit`: this
workspace has no Git history or canonical public repository URL. Those fields
must be filled by the project owner before any F-Droid lint or submission.

No signing key, store token, remote push or external publication belongs in
this repository.
