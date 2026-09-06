# KillQR

<p align="center">
  <img src="assets/branding/killqr-app-icon-opaque.png" alt="KillQR icon" width="168">
</p>

<h1 align="center">KillQR</h1>

<p align="center">
  <strong>Private, offline-first QR code and barcode toolkit for Android.</strong><br>
  Scan, generate, import and manage codes without an account, ads or cloud storage.
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml"><img src="https://github.com/leonardobordin/KillQR/actions/workflows/ci.yml/badge.svg" alt="CI status"></a>
  <a href="https://github.com/leonardobordin/KillQR/releases/latest"><img src="https://img.shields.io/github/v/release/leonardobordin/KillQR?display_name=tag" alt="Latest release"></a>
  <a href="https://developer.android.com/about/versions/oreo"><img src="https://img.shields.io/badge/Android-API%2026%2B-3DDC84?logo=android&logoColor=white" alt="Android API 26 or newer"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-Apache--2.0-2ea44f?logo=apache&logoColor=white" alt="Apache-2.0 license"></a>
</p>

<p align="center">
  <a href="https://github.com/leonardobordin/KillQR/releases/latest">Download latest APK</a> ·
  <a href="#highlights">Highlights</a> ·
  <a href="docs/BUILDING.md">Build guide</a> ·
  <a href="docs/PRIVACY.md">Privacy</a>
</p>

<p align="center">
  <a href="README.md">English</a> ·
  <a href="README.pt-BR.md">Português (Brasil)</a>
</p>

## Contents

- [Overview](#overview)
- [Highlights](#highlights)
- [Download](#download)
- [Build from source](#build-from-source)
- [Releases and automatic updates](#releases-and-automatic-updates)
- [Privacy and permissions](#privacy-and-permissions)
- [Project map](#project-map)
- [Contributing](#contributing)
- [Ownership and license](#ownership-and-license)

## Overview

KillQR is an offline-first Android application for scanning and generating QR
Codes and barcodes. Scans, generated content and history stay on the device.
The app does not require an account, telemetry, advertisements, Google Play
Services or cloud storage.

It is made for people who want a focused QR and barcode tool with useful
document support, local history and clear control over what leaves the device.

## Highlights

| Scan | Create | Keep control |
| --- | --- | --- |
| Camera, images, PDFs and supported Office documents | QR Codes and supported linear formats | Local history, private mode and no account |
| Multiple codes and continuous scanning | Custom RGB/HEX highlight color | Optional, user-controlled GitHub update checks |

### Scanning

- Scan QR Codes and barcodes with the camera or from selected images.
- Read multiple codes in one capture and use continuous scanning sessions.
- Resize the central scan area and adjust camera zoom from the scanner screen.
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
- Flashlight, camera switching, document import and scan modes are available in
  the top action bar, with an overflow menu on narrow screens.
- First-use explanations clarify continuous and multiple-code scanning, with a
  persistent option to stop showing them.
- Release notes shown once after an app update.
- Optional GitHub release checks with manual checking, **Remind me later** and
  **Don't remind me again** controls.

## Download

Download the latest signed APK from
[GitHub Releases](https://github.com/leonardobordin/KillQR/releases/latest), or
browse the [complete release history](https://github.com/leonardobordin/KillQR/releases).
Each release includes a SHA-256 checksum; verify it before installing the APK.

KillQR is currently distributed through GitHub Releases. Store publication is
not automated yet.

Read the [English changelog](CHANGELOG.md) or the
[Brazilian Portuguese changelog](CHANGELOG.pt-BR.md) for the release history.

## Build from source

### Requirements

- Flutter 3.47.2 / Dart 3.13.2;
- Android SDK API 36, Build Tools 36.x and NDK 28.2.13676358;
- Java 17 or a compatible Android Studio JDK;
- Android API 26 or newer.

### Validate and build

```powershell
git clone https://github.com/leonardobordin/KillQR.git
cd KillQR
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
[`release.yml`](.github/workflows/release.yml). The workflow validates the
project, runs tests, builds the signed APK, calculates its SHA-256 checksum and
publishes a GitHub Release.

The app can query official GitHub releases once a day or when requested in
Settings. Automatic checks can be disabled, postponed with **Remind me later**
or permanently dismissed with **Don't remind me again**. KillQR never installs
an APK silently: Android always asks the user to confirm installation.

The release process and required signing secrets are documented in
[`docs/RELEASING.md`](docs/RELEASING.md).

## Privacy and permissions

KillQR processes scans and history locally. The permissions have a narrow
purpose:

| Access | Used for |
| --- | --- |
| Camera | Live QR Code and barcode scanning |
| Photos/files | Only when the user selects an image or document, or exports a PNG |
| Internet | Optional GitHub release checks only |

Read the full policy in [`docs/PRIVACY.md`](docs/PRIVACY.md).

## Project map

| Path | Purpose |
| --- | --- |
| [`lib/`](lib/) | Flutter application source |
| [`test/`](test/) | Unit and widget tests |
| [`docs/BUILDING.md`](docs/BUILDING.md) | Local build and Android smoke test |
| [`docs/RELEASING.md`](docs/RELEASING.md) | Signed release process |
| [`docs/PRIVACY.md`](docs/PRIVACY.md) | Data and permission policy |
| [`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md) | Dependency license inventory |
| [`CHANGELOG.md`](CHANGELOG.md) | English release history |
| [`CHANGELOG.pt-BR.md`](CHANGELOG.pt-BR.md) | Brazilian Portuguese release history |

## Localization

The app ships with English and Brazilian Portuguese. Contributions to the
translation files are welcome; the localization source is under
[`lib/l10n/`](lib/l10n/).

## Contributing

Bug reports, feature ideas and pull requests are welcome. For changes that
affect scanning, document import, permissions or release behavior, include
the Android version and a short reproduction or validation note.

## Ownership and license

KillQR was created and is maintained by **Leonardo Silva Bordin**.

The source code is licensed under the
[Apache License 2.0](LICENSE). Copyright attribution is recorded in
[`NOTICE`](NOTICE). Dependency and third-party notices are listed in
[`docs/THIRD_PARTY_LICENSES.md`](docs/THIRD_PARTY_LICENSES.md).

KillQR is an independent project and is not affiliated with Google, Android,
GitHub, ZXing or any barcode provider. Referenced third-party names and assets
remain under their respective owners and licenses.

<p align="center">
  Made with care by <a href="https://github.com/leonardobordin"><strong>Leonardo Silva Bordin</strong></a>.
</p>
