# Changelog

All notable changes to KillQR are documented here.

## 0.1.5 - 2026-09-05

### Melhorias

- Added opt-in automatic and manual GitHub release checks in Settings.
- Added “Remind me later” and “Don't remind me again” update preferences.
- Added English as the default README language and a linked Brazilian Portuguese
  README.
- Added the creator attribution “Leonardo Silva Bordin” to the in-app About
  section and project documentation.
- Reorganized both READMEs with project branding, feature groups, download,
  build, privacy, release and ownership sections.
- Added GitHub Actions workflows for validation and APK release publication.

### Correções de bugs

- Update checks now respect the user's disabled and snoozed preferences.

## 0.1.4 - 2026-09-05

### Melhorias

- Replaced the Quick Settings tile artwork with a recognizable QR Code matrix.
- Renamed the tile to `Scan with KillQR` (Portuguese: `Escanear com KillQR`).

### Correções de bugs

- Corrected the tile label and icon shown by Android after the tile is added to
  the Quick Settings panel.

## 0.1.3 - 2026-09-05

### Melhorias

- Added an `Open KillQR` Android Quick Settings tile, available from the
  system's tile editor.
- Bumped the release to `0.1.3+4` with categorized update notes.

### Correções de bugs

- Fixed the multiple-code switch so its active state follows the configured
  accent color.

## 0.1.2 - 2026-09-05

### Melhorias

- Reorganized the in-app release notes into separate `Improvements` and `Bug
  fixes` sections.
- Replaced the scanner hint with a direct explanation that the option enables
  scanning multiple codes at the same time.
- Added a modal progress window labeled `Analyzing document…` while images,
  PDFs and Office documents are being processed.
- Bumped the release to `0.1.2+3` with update-specific notes shown once on the
  first launch after installation.

### Correções de bugs

- Fixed document imports being routed through continuous-mode handling when
  continuous scanning was enabled.

## 0.1.1 - 2026-09-05

- Moved the active continuous-mode indicator into the lower-right corner of
  the camera area, leaving the header height unchanged and the flash/front-
  camera controls unobstructed.
- Decoupled image, PDF and modern Office imports from continuous mode. Imported
  results now open the normal result flow and are stored with the `Imported`
  source, even when continuous scanning is enabled.
- Clarified the camera instruction so the `Multiple codes` switch explains
  that it reads several codes at once.
- Added monotonic version metadata (`0.1.1+2`) and a localized release-notes
  dialog shown once after each app update.

## 0.1.0 - 2026-09-05

- Added an offline Android QR/barcode scanner backed by `flutter_zxing`.
- Added safe local parsing for URLs, phone, SMS, email, Wi-Fi, contacts,
  events, geo coordinates and product codes.
- Added explicit confirmation before external intents and URL launches.
- Added local Drift/SQLite history with notes, favorites, tags and continuous
  scan sessions.
- Added JSON/CSV import and export with validation, size limits and duplicate
  policies.
- Added engine-backed barcode generation, content templates and PNG export.
- Added explicit PNG saving to the Android gallery with success feedback.
- Added an explicit offline file picker for images, PDFs and modern Office
  documents, with visible loading and no-code/error feedback. PDF pages are
  rasterized locally and embedded Office images are scanned for codes.
- Replaced the default launcher icon with the supplied KillQR neon QR logo and
  generated Android density-specific icon resources.
- Cropped the opaque launcher icon to the logo bounds so it fills the same
  square area as neighboring launcher icons without an external black margin.
- Improved PDF document decoding by preserving up to 3,000 px for full-page
  forms, trying inverted codes, and fixing the multiple-code toggle. A DAS
  payment PDF now returns both its Pix QR Code and ITF barcode.
- Document imports now scan all codes automatically; the camera-only multiple
  code setting no longer controls whether a PDF barcode is returned.
- Moved the continuous-mode indicator outside the camera action area so it no
  longer overlaps flash/front-camera controls. History now watches SQLite in
  real time and keeps pull-to-refresh available while loading or empty.
- Added Portuguese (Brazilian) and English localization, themes, AMOLED mode,
  contrast-aware accent colors, custom RGB/HEX accent selection and configurable
  product search engines.
- Made generator content input expand for longer text while keeping a bounded
  layout.
- Fixed linear barcode generation for CodaBar, EAN8, EAN13, ITF, UPCA and UPCE:
  selecting a format now suggests valid content, incompatible templates are
  disabled, manual input is validated and the generated code uses the correct
  one-dimensional aspect ratio.
- Added Android manifest audits and a release native smoke test.

This release is a source build candidate. It has not been published to a
store or submitted to F-Droid.
