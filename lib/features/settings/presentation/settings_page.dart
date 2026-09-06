import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app_providers.dart';
import '../../../core/database/app_database.dart';
import '../../../core/platform/external_action_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/update/release_update_service.dart';
import '../../../l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final settings = ref.watch(appSettingsProvider);
    final database = ref.watch(databaseProvider).requireValue;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _SectionTitle(title: l10n.theme),
          Card(
            child: RadioGroup<AppThemeChoice>(
              groupValue: settings.themeChoice,
              onChanged: (value) {
                if (value != null) settings.setTheme(value);
              },
              child: Column(
                children: [
                  RadioListTile<AppThemeChoice>(
                    title: Text(l10n.themeSystem),
                    value: AppThemeChoice.system,
                  ),
                  RadioListTile<AppThemeChoice>(
                    title: Text(l10n.themeLight),
                    value: AppThemeChoice.light,
                  ),
                  RadioListTile<AppThemeChoice>(
                    title: Text(l10n.themeDark),
                    value: AppThemeChoice.dark,
                  ),
                  RadioListTile<AppThemeChoice>(
                    title: Text(l10n.themeAmoled),
                    value: AppThemeChoice.amoled,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.accentColor),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (final color in _accentColors)
                        Semantics(
                          label: '${l10n.accentColor} ${_hexColor(color)}',
                          selected:
                              settings.accentColor.toARGB32() ==
                              color.toARGB32(),
                          button: true,
                          child: InkWell(
                            onTap: () => settings.setAccent(color),
                            borderRadius: BorderRadius.circular(24),
                            child: CircleAvatar(
                              backgroundColor: color,
                              child:
                                  settings.accentColor.toARGB32() ==
                                      color.toARGB32()
                                  ? Icon(
                                      Icons.check,
                                      color:
                                          AppSettingsController.readableForeground(
                                            color,
                                          ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      Semantics(
                        label:
                            '${l10n.customAccentColor} ${_hexColor(settings.accentColor)}',
                        button: true,
                        child: OutlinedButton.icon(
                          onPressed: () => _pickAccentColor(context, settings),
                          icon: const Icon(Icons.colorize_outlined),
                          label: Text(l10n.customAccentColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${l10n.customAccentColorHint}: ${_hexColor(settings.accentColor)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.scanner),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.saveAutomatically),
                  value: settings.saveAutomatically,
                  onChanged: settings.setSaveAutomatically,
                ),
                SwitchListTile(
                  title: Text(l10n.privateMode),
                  subtitle: Text(l10n.privateModeHint),
                  value: settings.privateMode,
                  onChanged: settings.setPrivateMode,
                ),
                ListTile(
                  title: Text(l10n.debounce),
                  subtitle: Slider(
                    value: settings.debounce.inMilliseconds.toDouble(),
                    min: 400,
                    max: 3000,
                    divisions: 13,
                    label: '${settings.debounce.inMilliseconds} ms',
                    onChanged: (value) => settings.setDebounce(
                      Duration(milliseconds: value.round()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.updates),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text(l10n.automaticUpdates),
                  subtitle: Text(l10n.automaticUpdatesHint),
                  value: settings.automaticUpdateChecks,
                  onChanged: settings.setAutomaticUpdateChecks,
                ),
                ListTile(
                  leading: const Icon(Icons.system_update_outlined),
                  title: Text(l10n.checkForUpdates),
                  subtitle: Text(l10n.checkForUpdatesHint),
                  onTap: () =>
                      checkForUpdates(context: context, settings: settings),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.searchEngines),
          _SearchEnginesCard(database: database),
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.language),
          Card(
            child: RadioGroup<AppLanguageChoice>(
              groupValue: settings.languageChoice,
              onChanged: (value) {
                if (value != null) settings.setLanguage(value);
              },
              child: Column(
                children: [
                  RadioListTile<AppLanguageChoice>(
                    title: Text(l10n.languageSystem),
                    value: AppLanguageChoice.system,
                  ),
                  RadioListTile<AppLanguageChoice>(
                    title: Text(l10n.languagePortuguese),
                    value: AppLanguageChoice.portugueseBrazil,
                  ),
                  RadioListTile<AppLanguageChoice>(
                    title: Text(l10n.languageEnglish),
                    value: AppLanguageChoice.english,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.privacy),
          Card(
            child: ListTile(
              leading: const Icon(Icons.lock_outline),
              title: Text(l10n.privacy),
              subtitle: Text(l10n.aboutText),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () =>
                const ExternalActionService().openApplicationSettings(),
            icon: const Icon(Icons.settings_outlined),
            label: Text(l10n.openAppSettings),
          ),
          const SizedBox(height: 16),
          _SectionTitle(title: l10n.about),
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code_2),
              title: const Text('KillQR'),
              subtitle: Text(
                '${l10n.version}\n${l10n.license}\n\n${l10n.aboutText}',
              ),
              isThreeLine: true,
              onTap: () => showAboutDialog(
                context: context,
                applicationName: 'KillQR',
                applicationVersion: l10n.version,
                applicationLegalese: l10n.license,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _pickAccentColor(
  BuildContext context,
  AppSettingsController settings,
) async {
  final color = await showDialog<Color>(
    context: context,
    builder: (_) =>
        _AccentColorPickerDialog(initialColor: settings.accentColor),
  );
  if (color != null) await settings.setAccent(color);
}

class _AccentColorPickerDialog extends StatefulWidget {
  const _AccentColorPickerDialog({required this.initialColor});

  final Color initialColor;

  @override
  State<_AccentColorPickerDialog> createState() =>
      _AccentColorPickerDialogState();
}

class _AccentColorPickerDialogState extends State<_AccentColorPickerDialog> {
  late final TextEditingController _hexController;
  late int _red;
  late int _green;
  late int _blue;
  String? _hexError;

  Color get _color => Color.fromARGB(255, _red, _green, _blue);

  @override
  void initState() {
    super.initState();
    _red = _colorChannel(widget.initialColor.r);
    _green = _colorChannel(widget.initialColor.g);
    _blue = _colorChannel(widget.initialColor.b);
    _hexController = TextEditingController(
      text: _hexColor(_color).substring(1),
    );
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l10n.customAccentColor),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 64,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                _hexColor(_color),
                style: TextStyle(
                  color: AppSettingsController.readableForeground(_color),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _hexController,
              maxLength: 6,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: l10n.hexColor,
                prefixText: '#',
                errorText: _hexError,
                counterText: '',
              ),
              onChanged: _onHexChanged,
            ),
            const SizedBox(height: 8),
            Text(l10n.red),
            Slider(
              value: _red.toDouble(),
              min: 0,
              max: 255,
              divisions: 255,
              label: '$_red',
              activeColor: Colors.red,
              onChanged: (value) => _updateChannel(red: value.round()),
            ),
            Text(l10n.green),
            Slider(
              value: _green.toDouble(),
              min: 0,
              max: 255,
              divisions: 255,
              label: '$_green',
              activeColor: Colors.green,
              onChanged: (value) => _updateChannel(green: value.round()),
            ),
            Text(l10n.blue),
            Slider(
              value: _blue.toDouble(),
              min: 0,
              max: 255,
              divisions: 255,
              label: '$_blue',
              activeColor: Colors.blue,
              onChanged: (value) => _updateChannel(blue: value.round()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(onPressed: _apply, child: Text(l10n.applyColor)),
      ],
    );
  }

  void _updateChannel({int? red, int? green, int? blue}) {
    setState(() {
      _red = red ?? _red;
      _green = green ?? _green;
      _blue = blue ?? _blue;
      _hexError = null;
      _hexController.text = _hexColor(_color).substring(1);
      _hexController.selection = TextSelection.collapsed(
        offset: _hexController.text.length,
      );
    });
  }

  void _onHexChanged(String value) {
    final color = _parseHexColor(value);
    if (color == null) {
      setState(() => _hexError = null);
      return;
    }
    setState(() {
      _red = _colorChannel(color.r);
      _green = _colorChannel(color.g);
      _blue = _colorChannel(color.b);
      _hexError = null;
    });
  }

  void _apply() {
    final color = _parseHexColor(_hexController.text);
    if (color == null) {
      final l10n = AppLocalizations.of(context)!;
      setState(() => _hexError = l10n.invalidHexColor);
      return;
    }
    Navigator.pop(context, color);
  }
}

class _SearchEnginesCard extends StatefulWidget {
  const _SearchEnginesCard({required this.database});

  final AppDatabase database;

  @override
  State<_SearchEnginesCard> createState() => _SearchEnginesCardState();
}

class _SearchEnginesCardState extends State<_SearchEnginesCard> {
  late Future<List<SearchEngine>> _future;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _future = widget.database.getSearchEngines();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: FutureBuilder<List<SearchEngine>>(
        future: _future,
        builder: (context, snapshot) {
          final engines = snapshot.data ?? const <SearchEngine>[];
          return Column(
            children: [
              if (snapshot.connectionState != ConnectionState.done)
                const LinearProgressIndicator(minHeight: 2),
              if (engines.isEmpty &&
                  snapshot.connectionState == ConnectionState.done)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(l10n.noSearchEngines),
                ),
              for (final engine in engines)
                ListTile(
                  leading: Icon(
                    engine.isActive ? Icons.search : Icons.search_off,
                  ),
                  title: Text(engine.name),
                  subtitle: Text(engine.template),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        tooltip: l10n.editSearchEngine,
                        onPressed: () => _edit(engine),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        tooltip: l10n.delete,
                        onPressed: () => _delete(engine),
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              ListTile(
                leading: const Icon(Icons.add),
                title: Text(l10n.addSearchEngine),
                onTap: () => _edit(null),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _edit(SearchEngine? existing) async {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController(text: existing?.name ?? '');
    final templateController = TextEditingController(
      text: existing?.template ?? 'https://duckduckgo.com/?q={CODE}',
    );
    var isActive = existing?.isActive ?? true;
    final form = await showDialog<_SearchEngineForm>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            existing == null ? l10n.addSearchEngine : l10n.editSearchEngine,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: l10n.searchEngineName),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: templateController,
                  decoration: InputDecoration(
                    labelText: l10n.searchEngineTemplate,
                    helperText: l10n.searchEngineTemplateHint,
                  ),
                  keyboardType: TextInputType.url,
                  maxLines: 2,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.enabled),
                  value: isActive,
                  onChanged: (value) => setDialogState(() => isActive = value),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(
                context,
                _SearchEngineForm(
                  name: nameController.text,
                  template: templateController.text,
                  isActive: isActive,
                ),
              ),
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
    nameController.dispose();
    templateController.dispose();
    if (form == null || !mounted) return;
    try {
      if (existing == null) {
        await widget.database.insertSearchEngine(
          name: form.name,
          template: form.template,
          isActive: form.isActive,
        );
      } else {
        await widget.database.updateSearchEngine(
          id: existing.id,
          name: form.name,
          template: form.template,
          isActive: form.isActive,
        );
      }
      setState(_reload);
    } on ArgumentError {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.invalidSearchTemplate)));
    }
  }

  Future<void> _delete(SearchEngine engine) async {
    await widget.database.deleteSearchEngine(engine.id);
    if (mounted) setState(_reload);
  }
}

class _SearchEngineForm {
  const _SearchEngineForm({
    required this.name,
    required this.template,
    required this.isActive,
  });

  final String name;
  final String template;
  final bool isActive;
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );
}

String _hexColor(Color color) =>
    '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

const _accentColors = <Color>[
  Color(0xFF4F46E5),
  Color(0xFF0F766E),
  Color(0xFFB45309),
  Color(0xFFBE123C),
  Color(0xFF7C3AED),
  Color(0xFF0369A1),
];

Color? _parseHexColor(String value) {
  final normalized = value.trim().replaceFirst('#', '');
  if (normalized.length != 6) return null;
  final rgb = int.tryParse(normalized, radix: 16);
  if (rgb == null) return null;
  return Color(0xFF000000 | rgb);
}

int _colorChannel(double component) =>
    (component * 255.0).round().clamp(0, 255).toInt();
