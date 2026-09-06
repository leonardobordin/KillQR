# KillQR

<p align="center">
  <img src="assets/branding/killqr-app-icon-opaque.png" alt="KillQR icon" width="180">
</p>

<h3 align="center">Offline QR Code and Barcode Scanner & Generator for Android</h3>

<p align="center">
  Private by default · No account · No ads · Open source
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/releases">Download</a> ·
  <a href="#features">Features</a> ·
  <a href="docs/BUILDING.md">Build guide</a> ·
  <a href="docs/PRIVACY.md">Privacy</a>
</p>

<p align="center">
  <a href="README.md">English</a> ·
  <a href="README.pt-BR.md">Português (Brasil)</a>
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml"><img src="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
  <a href="https://github.com/leonardobordin/KillQR/releases"><img src="https://img.shields.io/github/v/release/leonardobordin/KillQR?display_name=tag" alt="Latest release"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/leonardobordin/KillQR" alt="Apache-2.0 license"></a>
</p>

## What is KillQR?

KillQR is an offline-first Android application for scanning and generating QR
Codes and barcodes. Scans, generated content and history stay on the device.
The app does not require an account, telemetry, advertisements, Google Play
Services or cloud storage.

KillQR is created and maintained by **Leonardo Silva Bordin**.

## Features

### Scanning

- Scan QR Codes and barcodes with the camera or from selected images.
- Read multiple codes in one capture and use continuous scanning sessions.
- Import PDFs and modern Office documents, analyzing rendered pages or embedded
  images where supported.
- Parse URLs, phone numbers, SMS, e-mail, Wi-Fi, contacts, events, locations
  and product codes locally.
- Ask for confirmation before opening an external application or link.

### Generation

- Generate QR Codes and supported linear formats such as CodaBar, EAN-8,
  EAN-13, ITF, UPC-A and UPC-E.
- Choose a custom highlight color with RGB or HEX controls.
- Export generated codes as PNG files to the gallery and receive a save
  confirmation.

### History and data

- Keep a searchable local SQLite history with filters, favorites, notes, tags
  and scan sources.
- Import and export validated JSON and CSV files.
- Use private mode when a result should not be stored automatically.

### Android experience

- System, light, dark and AMOLED themes.
- English and Brazilian Portuguese translations.
- Quick Settings tile named **Scan with KillQR**.
- Release notes shown once after an app update.
- Optional GitHub release checks with manual checking, “Remind me later” and
  “Don't remind me again” controls.

## Download

Official APK files are published through [GitHub Releases](https://github.com/leonardobordin/KillQR/releases)
by the signed GitHub Actions release workflow. Check the SHA-256 file attached
to each release before installing an APK.

The project is currently distributed as a source-build candidate. Store
publication is not performed automatically.

## Build from source

### Requirements

- Flutter 3.47.2 / Dart 3.13.2;
- Android SDK API 36, Build Tools 36.x and NDK 28.2.13676358;
- Java 17 or a compatible Android Studio JDK;
- Android API 26 or newer.

### Validate and build

From the project root:

```powershell
flutter pub get
dart run build_runner build
flutter gen-l10n
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --release --dart-define=GITHUB_REPOSITORY=leonardobordin/KillQR
```

The APK is generated at
`build/app/outputs/flutter-apk/app-release.apk`. The complete Android smoke
flow is documented in [`docs/BUILDING.md`](docs/BUILDING.md).

## Releases and automatic updates

Push a semantic-version tag such as `v0.1.5` to run
[`.github/workflows/release.yml`](.github/workflows/release.yml). The workflow
validates the project, runs tests, builds the signed APK, calculates its
SHA-256 checksum and publishes a GitHub Release.

The release process and required signing secrets are documented in
[`docs/RELEASING.md`](docs/RELEASING.md). The app can query the official GitHub
releases once a day or when requested in Settings. It never installs an APK
silently: Android always asks the user to confirm installation.

## Privacy and permissions

KillQR processes scans and history locally. Network access is used only for the
optional GitHub release check. Camera access is used for camera scanning, and
document access is requested only when the user selects a file. PNG export uses
the appropriate gallery permission on older Android versions.

Read the full policy in [`docs/PRIVACY.md`](docs/PRIVACY.md).

## Localization

The app ships with English and Brazilian Portuguese. Contributions to the
translation files are welcome; the localization workflow is described in the
source tree under `lib/l10n/`.

## Ownership and license

KillQR is created and maintained by **Leonardo Silva Bordin**.

The source code is licensed under the [Apache License 2.0](LICENSE). Dependency
and third-party notices are listed in
[`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md). The project
name and icon identify KillQR; referenced third-party names and assets remain
under their respective owners and licenses.

## Acknowledgements

KillQR is built with Flutter, Drift, SQLite, ZXing and other open-source
libraries. See the [third-party license inventory](docs/THIRD_PARTY_LICENSES.md)
for the complete list.

## Disclaimer

KillQR is an independent project and is not affiliated with Google, Android,
GitHub, ZXing or any barcode provider. Always verify important data before
using a scanned result.

## Author

Made with care by **[Leonardo Silva Bordin](https://github.com/leonardobordin)**.
