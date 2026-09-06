# Third-party license inventory

This is the initial dependency inventory for the bootstrap. It is not the
final release notice; the release phase must regenerate and review it from
`pubspec.lock`, the native sources, and Gradle dependencies.

| Dependency | Version resolved | License / source | Runtime role |
| --- | ---: | --- | --- |
| Flutter SDK | 3.47.2 | BSD-3-Clause | Android application framework |
| flutter_zxing | 3.0.1 | MIT | ZXing-C++ scanner/encoder bridge |
| archive | 4.2.0 | MIT | Local extraction of embedded media from modern Office ZIP documents |
| camera | 0.12.1 | BSD-3-Clause | CameraX-backed camera plugin, transitively used by flutter_zxing |
| drift | 2.34.4 | MIT | Typed SQLite access and migrations |
| sqlite3 | 3.5.2 | MIT bindings; SQLite public domain | Native SQLite access |
| flutter_riverpod | 3.4.3 | MIT | State/injection foundation |
| file_selector | 1.1.0 | BSD-3-Clause | Native file selection |
| image_picker | 1.2.3 | Apache-2.0/BSD-3-Clause by component | Native image selection |
| path_provider | 2.1.6 | BSD-3-Clause | App-private storage path |
| share_plus | 13.3.0 | BSD-3-Clause | Android Sharesheet adapter |
| shared_preferences | 2.5.5 | BSD-3-Clause | Local preferences |
| url_launcher | 6.3.2 | BSD-3-Clause | Explicit external intents |
| android_intent_plus | 6.1.0 | BSD-3-Clause | Explicit Android intent adapter |
| intl | 0.20.3 | BSD-3-Clause | Formatting/localization support |
| flutter_localizations | Flutter SDK | BSD-3-Clause | Generated ARB localization support |
| flutter_lints | 6.0.0 | BSD-3-Clause | Development analysis rules |
| ffi | 2.2.0 | BSD-3-Clause | Dart/native bridge used by scanner and SQLite |
| image | 4.9.2 | MIT | Image conversion used by flutter_zxing |
| hooks | 2.0.2 | BSD-3-Clause | sqlite3 native build hooks |
| async / collection / meta / path | resolved transitives | BSD-3-Clause / MIT as declared | Dart and Drift runtime support |
| Kotlin / AndroidX / CameraX | Gradle transitives | Apache-2.0 / BSD-3-Clause as declared upstream | Android build and camera runtime |

The exact resolved versions are in `pubspec.lock`; Gradle's resolved graph is
audited from the Android build cache during release review. `sqlite3` uses
the modern Dart hooks path; no `sqlite3_flutter_libs` compatibility package
is added. SQLite itself is public-domain software, while the Dart bindings are
MIT. The source-build behavior still needs to be checked by an actual F-Droid
builder before a submission.

Native code and all transitive dependencies still require the release audit.
No Google Play Services, Firebase, ML Kit, advertising SDK, telemetry SDK or
runtime network feature is part of the intended application architecture.
