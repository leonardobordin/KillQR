import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../core/update/release_update_service.dart';
import '../core/version/app_release.dart';
import '../l10n/app_localizations.dart';
import 'app_providers.dart';
import 'app_shell.dart';

class KillQrApp extends ConsumerWidget {
  const KillQrApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: settings.lightTheme(),
      darkTheme: settings.themeChoice == AppThemeChoice.amoled
          ? settings.amoledTheme()
          : settings.darkTheme(),
      themeMode: settings.materialThemeMode,
      locale: settings.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      home: const _DatabaseBootstrapGate(),
    );
  }
}

class _DatabaseBootstrapGate extends ConsumerWidget {
  const _DatabaseBootstrapGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);
    final l10n = AppLocalizations.of(context)!;
    return database.when(
      loading: () => _BootstrapScaffold(
        icon: Icons.shield_outlined,
        title: l10n.bootstrapStarting,
        message: l10n.bootstrapDescription,
      ),
      error: (error, _) => _BootstrapScaffold(
        icon: Icons.error_outline,
        title: l10n.bootstrapFailed,
        message: l10n.bootstrapErrorDetails,
        action: FilledButton.icon(
          onPressed: () => ref.invalidate(databaseProvider),
          icon: const Icon(Icons.refresh),
          label: Text(l10n.retry),
        ),
      ),
      data: (_) => AppUpdateChangelogGate(
        child: const AppShell(),
        onCompleted: (context) => checkForUpdates(
          context: context,
          settings: ref.read(appSettingsProvider),
          automatic: true,
        ),
      ),
    );
  }
}

class _BootstrapScaffold extends StatelessWidget {
  const _BootstrapScaffold({
    required this.icon,
    required this.title,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              if (action != null) ...[const SizedBox(height: 24), action!],
            ],
          ),
        ),
      ),
    );
  }
}
