import 'package:flutter_test/flutter_test.dart';
import 'package:killqr/core/update/release_update_service.dart';

void main() {
  test('parses a GitHub release and selects its APK asset', () {
    final release = GitHubRelease.fromJson({
      'tag_name': 'v0.2.0',
      'name': 'KillQR 0.2.0',
      'body': '### Improvements',
      'html_url': 'https://github.com/example/killqr/releases/tag/v0.2.0',
      'assets': [
        {
          'name': 'KillQR-0.2.0.apk',
          'browser_download_url':
              'https://github.com/example/killqr/releases/download/v0.2.0/KillQR-0.2.0.apk',
        },
      ],
    });

    expect(release.version, '0.2.0');
    expect(release.title, 'KillQR 0.2.0');
    expect(release.apkUrl?.path, contains('KillQR-0.2.0.apk'));
  });

  test('compares semantic release versions independently from build numbers', () {
    expect(
      GitHubReleaseService.isVersionNewer('v0.2.0', '0.1.5+6'),
      isTrue,
    );
    expect(
      GitHubReleaseService.isVersionNewer('0.1.5', '0.1.5+6'),
      isFalse,
    );
    expect(
      GitHubReleaseService.isVersionNewer('0.1.4', '0.1.5'),
      isFalse,
    );
  });

  test('rejects a release that points outside HTTPS', () {
    expect(
      () => GitHubRelease.fromJson({
        'tag_name': 'v0.2.0',
        'html_url': 'http://github.com/example/killqr/releases/tag/v0.2.0',
      }),
      throwsA(isA<ReleaseUpdateException>()),
    );
  });
}
