import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../version/app_release.dart';

enum ReleaseUpdateError { notConfigured, network, invalidResponse }

class ReleaseUpdateException implements Exception {
  const ReleaseUpdateException(this.error);

  final ReleaseUpdateError error;
}

class GitHubRelease {
  const GitHubRelease({
    required this.tagName,
    required this.title,
    required this.body,
    required this.htmlUrl,
    this.apkUrl,
  });

  final String tagName;
  final String title;
  final String body;
  final Uri htmlUrl;
  final Uri? apkUrl;

  String get version => _normalizeVersion(tagName);

  static GitHubRelease fromJson(Map<String, dynamic> json) {
    final tagName = json['tag_name'];
    final htmlUrl = _httpsUri(json['html_url']);
    if (tagName is! String || tagName.trim().isEmpty || htmlUrl == null) {
      throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
    }

    Uri? apkUrl;
    final assets = json['assets'];
    if (assets is List) {
      for (final asset in assets) {
        if (asset is! Map) continue;
        final name = asset['name'];
        if (name is! String || !name.toLowerCase().endsWith('.apk')) continue;
        final candidate = _httpsUri(asset['browser_download_url']);
        if (candidate != null) {
          apkUrl = candidate;
          break;
        }
      }
    }

    return GitHubRelease(
      tagName: tagName.trim(),
      title: (json['name'] as String?)?.trim() ?? '',
      body: (json['body'] as String?)?.trim() ?? '',
      htmlUrl: htmlUrl,
      apkUrl: apkUrl,
    );
  }

  static Uri? _httpsUri(Object? value) {
    if (value is! String) return null;
    final uri = Uri.tryParse(value);
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) return null;
    return uri;
  }
}

class ReleaseUpdateResult {
  const ReleaseUpdateResult({this.release, this.error});

  final GitHubRelease? release;
  final ReleaseUpdateError? error;

  bool get hasUpdate => release != null;
}

class GitHubReleaseService {
  GitHubReleaseService({String? repository})
    : repository = (repository ?? _compiledRepository).trim();

  static const _compiledRepository = String.fromEnvironment(
    'GITHUB_REPOSITORY',
  );

  final String repository;

  Future<ReleaseUpdateResult> checkForUpdate() async {
    try {
      final latest = await fetchLatest();
      return ReleaseUpdateResult(
        release: _isNewer(latest.version, AppRelease.version) ? latest : null,
      );
    } on ReleaseUpdateException catch (error) {
      return ReleaseUpdateResult(error: error.error);
    } on Object {
      return const ReleaseUpdateResult(error: ReleaseUpdateError.network);
    }
  }

  Future<GitHubRelease> fetchLatest() async {
    final endpoint = _latestEndpoint;
    if (endpoint == null) {
      throw const ReleaseUpdateException(ReleaseUpdateError.notConfigured);
    }

    final client = HttpClient()..connectionTimeout = const Duration(seconds: 8);
    try {
      final request = await client
          .getUrl(endpoint)
          .timeout(const Duration(seconds: 10));
      request.headers
        ..set(HttpHeaders.acceptHeader, 'application/vnd.github+json')
        ..set(HttpHeaders.userAgentHeader, 'KillQR/${AppRelease.version}')
        ..set('X-GitHub-Api-Version', '2022-11-28');
      final response = await request.close().timeout(
        const Duration(seconds: 10),
      );
      final body = await response
          .transform(utf8.decoder)
          .join()
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != HttpStatus.ok) {
        throw const ReleaseUpdateException(ReleaseUpdateError.network);
      }
      final decoded = jsonDecode(body);
      if (decoded is! Map<String, dynamic>) {
        throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
      }
      return GitHubRelease.fromJson(decoded);
    } on ReleaseUpdateException {
      rethrow;
    } on TimeoutException {
      throw const ReleaseUpdateException(ReleaseUpdateError.network);
    } on FormatException {
      throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
    } on SocketException {
      throw const ReleaseUpdateException(ReleaseUpdateError.network);
    } finally {
      client.close(force: true);
    }
  }

  Future<bool> openDownload(GitHubRelease release) => launchUrl(
    release.apkUrl ?? release.htmlUrl,
    mode: LaunchMode.externalApplication,
  );

  static bool isVersionNewer(String candidate, String current) =>
      _isNewer(candidate, current);

  Uri? get _latestEndpoint {
    final parts = repository.split('/');
    if (parts.length != 2 || parts.any((part) => part.trim().isEmpty)) {
      return null;
    }
    return Uri.https(
      'api.github.com',
      '/repos/${parts[0].trim()}/${parts[1].trim()}/releases/latest',
    );
  }

  static bool _isNewer(String candidate, String current) =>
      _compareVersions(candidate, current) > 0;

  static int _compareVersions(String first, String second) {
    final firstParts = _versionParts(first);
    final secondParts = _versionParts(second);
    for (var index = 0; index < 3; index++) {
      final comparison = firstParts[index].compareTo(secondParts[index]);
      if (comparison != 0) return comparison;
    }
    return 0;
  }

  static List<int> _versionParts(String value) {
    final match = RegExp(r'^v?(\d+)\.(\d+)\.(\d+)').firstMatch(value.trim());
    if (match == null) {
      throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
    }
    return [
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    ];
  }
}

Future<void> checkForUpdates({
  required BuildContext context,
  required AppSettingsController settings,
  bool automatic = false,
}) async {
  await settings.load();
  if (automatic && !settings.shouldCheckAutomatically) return;
  await settings.markUpdateCheck();

  final service = GitHubReleaseService();
  if (!context.mounted) return;
  final navigator = Navigator.of(context, rootNavigator: true);
  unawaited(
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.checkingUpdates),
        content: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            SizedBox(width: 16),
            Flexible(child: Text('…')),
          ],
        ),
      ),
    ),
  );
  await Future<void>.delayed(const Duration(milliseconds: 50));

  final result = await service.checkForUpdate();
  if (navigator.mounted && navigator.canPop()) navigator.pop();
  if (!context.mounted) return;

  if (result.hasUpdate) {
    final action = await _showUpdateAvailable(context, result.release!);
    switch (action) {
      case _UpdateAction.download:
        final opened = await service.openDownload(result.release!);
        if (!opened && context.mounted) {
          _showMessage(context, AppLocalizations.of(context)!.updateOpenFailed);
        }
      case _UpdateAction.later:
        await settings.snoozeUpdateChecks();
      case _UpdateAction.never:
        await settings.setAutomaticUpdateChecks(false);
      case null:
        break;
    }
    return;
  }

  if (automatic) return;
  final l10n = AppLocalizations.of(context)!;
  final message = switch (result.error) {
    ReleaseUpdateError.notConfigured => l10n.updatesNotConfigured,
    ReleaseUpdateError.network ||
    ReleaseUpdateError.invalidResponse => l10n.updateCheckFailed,
    null => l10n.noUpdatesAvailable,
  };
  _showMessage(context, message);
}

Future<_UpdateAction?> _showUpdateAvailable(
  BuildContext context,
  GitHubRelease release,
) {
  final l10n = AppLocalizations.of(context)!;
  return showDialog<_UpdateAction>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.updateAvailable),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.updateVersionAvailable(release.version)),
              if (release.title.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  release.title,
                  style: Theme.of(dialogContext).textTheme.titleMedium,
                ),
              ],
              if (release.body.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(l10n.updateReleaseNotes),
                const SizedBox(height: 4),
                Text(release.body),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, _UpdateAction.never),
          child: Text(l10n.neverRemind),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, _UpdateAction.later),
          child: Text(l10n.remindLater),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, _UpdateAction.download),
          child: Text(l10n.downloadUpdate),
        ),
      ],
    ),
  );
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

enum _UpdateAction { download, later, never }

String _normalizeVersion(String value) {
  final match = RegExp(r'^v?(\d+\.\d+\.\d+)').firstMatch(value.trim());
  if (match == null) {
    throw const ReleaseUpdateException(ReleaseUpdateError.invalidResponse);
  }
  return match.group(1)!;
}
