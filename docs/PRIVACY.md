# KillQR privacy

KillQR is designed to work without an account and works offline by default.

- Scanned values, notes, favorites, tags and settings stay in the app's
  private storage.
- Camera frames and imported images are processed for the requested operation
  and are not added to the history.
- Imported PDFs are rendered page-by-page in the app's private cache, and
  modern Office files are inspected only for embedded image media; temporary
  rendered pages are removed after scanning. Documents are not uploaded.
- There is no analytics, advertising, crash-reporting, Firebase, Google ML Kit,
  Play Services or embedded browser dependency.
- `CAMERA` is requested only by the scanner flow. On Android API 26–28,
  `WRITE_EXTERNAL_STORAGE` is requested only after the user chooses to save a
  PNG to the gallery, and is constrained to those legacy API levels; Android
  API 29+ uses `MediaStore` without storage permission.
- Opening a URL, dialer, SMS composer, mail app, map, contact editor, event
  editor, Wi-Fi settings or product search is always a user-confirmed action in
  another application.
- The optional update checker contacts only the public GitHub releases API and
  is used only when automatic checks are enabled or the user requests a manual
  check. It sends no scan data, account information, telemetry, or device
  identifiers. Selecting an update opens the GitHub APK/release page for the
  user to confirm installation.
- JSON and CSV export files exist only when the user explicitly chooses a
  destination or share target. Exported data is not encrypted by KillQR.
- Generated PNGs are written to the user-visible `Pictures/KillQR` gallery
  folder only after an explicit save action.
- Automatic Android backup is disabled and the backup rule files exclude the
  local database and preferences. Move data between installations with a
  user-initiated export/import instead.

The Apache-2.0 license applies to this project. See
`docs/THIRD_PARTY_LICENSES.md` for the dependency inventory.
