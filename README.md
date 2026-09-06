# KillQR

[English](README.md) · [Português (Brasil)](README.pt-BR.md)

KillQR is an offline-first Android QR code and barcode scanner and generator.
Scans and history stay on the device. No account, telemetry, ads, Google Play
Services, or cloud storage are required.

## Features

- camera and image scanning, including multiple codes;
- local parsing for URLs, phone numbers, SMS, e-mail, Wi-Fi, contacts, events,
  locations, and product codes;
- confirmation before opening an external application;
- local SQLite history with search, filters, favorites, notes, tags, and
  continuous-scan sessions;
- QR and barcode generation through the real ZXing capabilities, including PNG
  export;
- JSON and CSV import/export with validation and duplicate handling;
- System, Light, Dark, and AMOLED themes; English and Brazilian Portuguese;
- optional GitHub release checks that can be disabled in Settings.

## Requirements

- Flutter 3.47.2 / Dart 3.13.2;
- Android SDK API 36, Build Tools 36.x, and NDK 28.2.13676358;
- Java 17 for the F-Droid-like validation (Android Studio Java 25 is also
  compatible with this project's Gradle 9.3.1);
- Android API 26 or newer.

## Build and validate

From the project root:

```powershell
flutter pub get --offline
dart run build_runner build
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --release --dart-define=GITHUB_REPOSITORY=OWNER/KillQR
powershell -ExecutionPolicy Bypass -File scripts/audit_android.ps1
powershell -ExecutionPolicy Bypass -File scripts/check_prohibited_dependencies.ps1
```

The product APK is `build/app/outputs/flutter-apk/app-release.apk`. The full
Android smoke flow is documented in [`docs/BUILDING.md`](docs/BUILDING.md).

`GITHUB_REPOSITORY` is automatically supplied by the GitHub Actions release
workflow. Local builds should replace `OWNER/KillQR` with the real repository.
The app only accesses the network when checking for releases; scanning and
history remain local.

## GitHub releases and updates

Push a semantic-version tag such as `v0.1.5` to trigger
`.github/workflows/release.yml`. The workflow analyzes, tests, builds the
release APK, calculates its SHA-256 checksum, and publishes both files to a
GitHub Release.

Signing setup and the release checklist are documented in
[`docs/RELEASING.md`](docs/RELEASING.md).

In the app, Settings provides automatic checks, manual checks, “Remind me
later,” and “Don't remind me again.” Android always asks the user to confirm an
APK installation; the app never installs an update silently.

## Privacy and licenses

See [`docs/PRIVACY.md`](docs/PRIVACY.md), [`LICENSE`](LICENSE), and the
dependency inventory in [`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md).
The `metadata/` directory is an F-Droid draft and does not publish or submit
anything automatically.

## Distribution status

Version `0.1.5+6` is a source-build candidate. No store publication is
performed automatically by this project.
