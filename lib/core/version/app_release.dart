import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/app_localizations.dart';

/// Version and release-note metadata shown to the user after an update.
class AppRelease {
  const AppRelease._();

  static const version = '0.1.6';
  static const buildNumber = 7;
  static const fullVersion = '$version+$buildNumber';
  static const _lastSeenPreference = 'last_seen_release';
}

/// Shows the current release notes once after the installed version changes.
class AppUpdateChangelogGate extends StatefulWidget {
  const AppUpdateChangelogGate({
    required this.child,
    this.onCompleted,
    super.key,
  });

  final Widget child;
  final Future<void> Function(BuildContext context)? onCompleted;

  @override
  State<AppUpdateChangelogGate> createState() => _AppUpdateChangelogGateState();
}

class _AppUpdateChangelogGateState extends State<AppUpdateChangelogGate> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showReleaseNotesIfNeeded();
    });
  }

  Future<void> _showReleaseNotesIfNeeded() async {
    if (_checked || !mounted) return;
    _checked = true;

    final preferences = SharedPreferencesAsync();
    String? lastSeen;
    try {
      lastSeen = await preferences.getString(AppRelease._lastSeenPreference);
    } on Object {
      lastSeen = null;
    }
    if (mounted && lastSeen != AppRelease.fullVersion) {
      final l10n = AppLocalizations.of(context)!;
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(l10n.releaseNotesTitle),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.updatedToVersion(AppRelease.fullVersion),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(l10n.releaseNotesIntro),
                  const SizedBox(height: 8),
                  _ReleaseNotesSectionTitle(
                    text: l10n.releaseNotesImprovementsTitle,
                  ),
                  _ReleaseNote(text: l10n.releaseNoteScanArea),
                  _ReleaseNote(text: l10n.releaseNoteTopControls),
                  _ReleaseNote(text: l10n.releaseNoteZoom),
                  _ReleaseNote(text: l10n.releaseNoteModeHelp),
                  const SizedBox(height: 8),
                  _ReleaseNotesSectionTitle(
                    text: l10n.releaseNotesBugFixesTitle,
                  ),
                  _ReleaseNote(text: l10n.releaseNoteCameraOverlay),
                ],
              ),
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.continueLabel),
            ),
          ],
        ),
      );

      try {
        await preferences.setString(
          AppRelease._lastSeenPreference,
          AppRelease.fullVersion,
        );
      } on Object {
        // Showing the app must not be blocked if preferences are unavailable.
      }
    }

    if (mounted) await widget.onCompleted?.call(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _ReleaseNote extends StatelessWidget {
  const _ReleaseNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 10),
            child: Icon(Icons.check_circle, size: 14),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _ReleaseNotesSectionTitle extends StatelessWidget {
  const _ReleaseNotesSectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
