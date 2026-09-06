import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/generator/presentation/generator_page.dart';
import '../features/history/presentation/history_page.dart';
import '../features/scanner/presentation/scanner_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../l10n/app_localizations.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = <Widget>[
      ScannerPage(isActive: _selectedIndex == 0),
      const HistoryPage(),
      const GeneratorPage(),
      const SettingsPage(),
    ];
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.qr_code_scanner),
            label: l10n.scanner,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history),
            label: l10n.history,
          ),
          NavigationDestination(
            icon: const Icon(Icons.add_box_outlined),
            label: l10n.create,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
