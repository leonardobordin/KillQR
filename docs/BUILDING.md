# Building KillQR

KillQR targets Android only, with a minimum API level of 26. The project is
currently pinned to Flutter 3.47.2 / Dart 3.13.2 and resolves dependencies from
`pubspec.lock`.

## Local checks

From the repository root:

```text
flutter pub get --offline
dart run build_runner build
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --release
powershell -ExecutionPolicy Bypass -File scripts/audit_android.ps1 -ApkPath build/app/outputs/flutter-apk/app-release.apk
powershell -ExecutionPolicy Bypass -File scripts/check_prohibited_dependencies.ps1
```

The debug and profile manifests intentionally do not include the Flutter
template's `INTERNET` permission. As a result, hot reload/debug transport may
not work; use local tests and APK builds for the offline validation path.

The Flutter `integration_test` runner is not configured in this project because
its Android driver requires a Dart VM service socket, which conflicts with the
no-`INTERNET` manifest policy. Android-side native validation uses the dedicated
release smoke target instead:

```text
flutter build apk --release --target=lib/spikes/native_smoke.dart
adb install -r build/app/outputs/flutter-apk/app-release.apk
adb shell am force-stop com.killstreak.killqr
adb shell am start -n com.killstreak.killqr/.MainActivity
```

The smoke target proves the Drift database opens and a QR payload completes a
real ZXing encode/decode round trip. Rebuild without `--target` before treating
the APK as the product build.

The scanner's file action uses the Android document picker for images, PDFs and
modern Office containers (`DOCX`, `XLSX`, `PPTX` and macro-enabled variants).
PDF pages are rasterized locally with Android `PdfRenderer`; Office scanning
checks embedded image media. Legacy binary Office files and QR codes drawn as
text/vector shapes are not rendered by the offline implementation.

The first phase uses Drift's `NativeDatabase.createInBackground` and the
sqlite3 Dart hooks. The F-Droid source-build decision remains open until the
native SQLite compilation is reproduced from an accepted source toolchain.

## Toolchain matrix

| Component | Validated value |
| --- | --- |
| Flutter / Dart | 3.47.2 / 3.13.2 stable |
| Android Gradle Plugin | 9.1.0 |
| Gradle wrapper | 9.3.1 |
| Kotlin | 2.4.0 |
| compile/target SDK | Flutter SDK API 36 |
| min SDK | API 26 |
| NDK | 28.2.13676358 |
| Java cross-check | Temurin 17.0.20.1 |
| Android Studio JBR | OpenJDK 25.0.2 |

For the cross-check, set `JAVA_HOME` to a Java 17 installation before the
release command. The application build was also repeated with the Android
Studio JBR. The portable Java 17 archive used during local validation lives
outside this source tree and is not a project dependency.

## Explicit emulator smoke

The helper below installs the dedicated smoke target and starts the correct
package/component. It intentionally stops the old `com.planejador.planejador`
package because that package was present on the development AVD before KillQR
was created:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/run_android_smoke.ps1
```

After the smoke, rebuild `flutter build apk --release` without `--target`; the
last build target otherwise remains the smoke application.

## Offline and release audit

`flutter pub get --offline` checks that the lockfile and local cache are enough
for Dart resolution. Gradle uses the wrapper and the source build contains no
runtime network feature. The audit scripts inspect source and merged APK
permissions and reject `INTERNET`, network-state, audio and broad storage
permissions. The only storage exception is `WRITE_EXTERNAL_STORAGE` constrained
to `maxSdkVersion=28`, used only for the explicit gallery-save action on legacy
Android; API 29+ uses `MediaStore` without storage permission.

The release APK is currently signed with the Flutter template debug key only
so it can be installed for local QA. A distribution build must be signed by
the distribution pipeline; no signing key belongs in this repository.
