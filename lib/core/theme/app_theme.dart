import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeChoice { system, light, dark, amoled }

enum AppLanguageChoice { system, portugueseBrazil, english }

final appSettingsProvider = ChangeNotifierProvider<AppSettingsController>(
  (ref) => AppSettingsController()..load(),
);

class AppSettingsController extends ChangeNotifier {
  SharedPreferencesAsync? _preferences;
  Future<void>? _loadOperation;

  SharedPreferencesAsync get _preferenceStore =>
      _preferences ??= SharedPreferencesAsync();

  AppThemeChoice themeChoice = AppThemeChoice.system;
  AppLanguageChoice languageChoice = AppLanguageChoice.system;
  Color accentColor = const Color(0xFF4F46E5);
  bool saveAutomatically = true;
  bool privateMode = false;
  bool continuousMode = false;
  bool continuousModeHelpDismissed = false;
  bool multipleScanHelpDismissed = false;
  Duration debounce = const Duration(milliseconds: 1200);
  bool initialTorch = false;
  bool automaticUpdateChecks = true;
  DateTime? _lastUpdateCheckAt;
  DateTime? _updateSnoozedUntil;

  static const updateCheckInterval = Duration(hours: 24);

  bool get shouldCheckAutomatically {
    if (!automaticUpdateChecks) return false;
    final now = DateTime.now();
    final snoozedUntil = _updateSnoozedUntil;
    if (snoozedUntil != null && now.isBefore(snoozedUntil)) return false;
    final lastCheck = _lastUpdateCheckAt;
    return lastCheck == null ||
        now.difference(lastCheck) >= updateCheckInterval;
  }

  Future<void> load() => _loadOperation ??= _load();

  Future<void> _load() async {
    final theme = await _preferenceStore.getString('theme_choice');
    final language = await _preferenceStore.getString('language_choice');
    final accent = await _preferenceStore.getInt('accent_color');
    themeChoice = _enumFromName(
      AppThemeChoice.values,
      theme,
      AppThemeChoice.system,
    );
    languageChoice = _enumFromName(
      AppLanguageChoice.values,
      language,
      AppLanguageChoice.system,
    );
    if (accent != null) accentColor = Color(accent);
    saveAutomatically =
        await _preferenceStore.getBool('save_automatically') ?? true;
    privateMode = await _preferenceStore.getBool('private_mode') ?? false;
    continuousMode = await _preferenceStore.getBool('continuous_mode') ?? false;
    continuousModeHelpDismissed =
        await _preferenceStore.getBool('continuous_mode_help_dismissed') ??
        false;
    multipleScanHelpDismissed =
        await _preferenceStore.getBool('multiple_scan_help_dismissed') ?? false;
    initialTorch = await _preferenceStore.getBool('initial_torch') ?? false;
    automaticUpdateChecks =
        await _preferenceStore.getBool('automatic_update_checks') ?? true;
    final lastUpdateCheckMs = await _preferenceStore.getInt(
      'last_update_check_ms',
    );
    if (lastUpdateCheckMs != null) {
      _lastUpdateCheckAt = DateTime.fromMillisecondsSinceEpoch(
        lastUpdateCheckMs,
      );
    }
    final updateSnoozedUntilMs = await _preferenceStore.getInt(
      'update_snoozed_until_ms',
    );
    if (updateSnoozedUntilMs != null) {
      _updateSnoozedUntil = DateTime.fromMillisecondsSinceEpoch(
        updateSnoozedUntilMs,
      );
    }
    final debounceMs = await _preferenceStore.getInt('debounce_ms');
    if (debounceMs != null) debounce = Duration(milliseconds: debounceMs);
    notifyListeners();
  }

  ThemeMode get materialThemeMode {
    switch (themeChoice) {
      case AppThemeChoice.system:
        return ThemeMode.system;
      case AppThemeChoice.light:
        return ThemeMode.light;
      case AppThemeChoice.dark:
      case AppThemeChoice.amoled:
        return ThemeMode.dark;
    }
  }

  Locale? get locale {
    switch (languageChoice) {
      case AppLanguageChoice.system:
        return null;
      case AppLanguageChoice.portugueseBrazil:
        return const Locale('pt', 'BR');
      case AppLanguageChoice.english:
        return const Locale('en');
    }
  }

  Future<void> setTheme(AppThemeChoice value) async {
    themeChoice = value;
    notifyListeners();
    await _preferenceStore.setString('theme_choice', value.name);
  }

  Future<void> setLanguage(AppLanguageChoice value) async {
    languageChoice = value;
    notifyListeners();
    await _preferenceStore.setString('language_choice', value.name);
  }

  Future<void> setAccent(Color value) async {
    accentColor = value;
    notifyListeners();
    await _preferenceStore.setInt('accent_color', value.toARGB32());
  }

  Future<void> setSaveAutomatically(bool value) async {
    saveAutomatically = value;
    notifyListeners();
    await _preferenceStore.setBool('save_automatically', value);
  }

  Future<void> setPrivateMode(bool value) async {
    privateMode = value;
    notifyListeners();
    await _preferenceStore.setBool('private_mode', value);
  }

  Future<void> setContinuousMode(bool value) async {
    continuousMode = value;
    notifyListeners();
    await _preferenceStore.setBool('continuous_mode', value);
  }

  Future<void> setContinuousModeHelpDismissed(bool value) async {
    continuousModeHelpDismissed = value;
    notifyListeners();
    await _preferenceStore.setBool('continuous_mode_help_dismissed', value);
  }

  Future<void> setMultipleScanHelpDismissed(bool value) async {
    multipleScanHelpDismissed = value;
    notifyListeners();
    await _preferenceStore.setBool('multiple_scan_help_dismissed', value);
  }

  Future<void> setInitialTorch(bool value) async {
    initialTorch = value;
    notifyListeners();
    await _preferenceStore.setBool('initial_torch', value);
  }

  Future<void> setDebounce(Duration value) async {
    debounce = value;
    notifyListeners();
    await _preferenceStore.setInt('debounce_ms', value.inMilliseconds);
  }

  Future<void> setAutomaticUpdateChecks(bool value) async {
    automaticUpdateChecks = value;
    if (value) {
      _updateSnoozedUntil = null;
      _lastUpdateCheckAt = null;
    }
    notifyListeners();
    await _preferenceStore.setBool('automatic_update_checks', value);
    if (value) {
      await _preferenceStore.remove('update_snoozed_until_ms');
      await _preferenceStore.remove('last_update_check_ms');
    }
  }

  Future<void> markUpdateCheck() async {
    _lastUpdateCheckAt = DateTime.now();
    notifyListeners();
    await _preferenceStore.setInt(
      'last_update_check_ms',
      _lastUpdateCheckAt!.millisecondsSinceEpoch,
    );
  }

  Future<void> snoozeUpdateChecks({
    Duration duration = const Duration(days: 1),
  }) async {
    _updateSnoozedUntil = DateTime.now().add(duration);
    notifyListeners();
    await _preferenceStore.setInt(
      'update_snoozed_until_ms',
      _updateSnoozedUntil!.millisecondsSinceEpoch,
    );
  }

  ThemeData lightTheme() => _theme(Brightness.light);

  ThemeData darkTheme() => _theme(Brightness.dark);

  ThemeData amoledTheme() => _theme(Brightness.dark, amoled: true);

  ThemeData _theme(Brightness brightness, {bool amoled = false}) {
    final scheme = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );
    final adjustedScheme = scheme.copyWith(
      primary: accentColor,
      onPrimary: readableForeground(accentColor),
      surface: amoled ? Colors.black : scheme.surface,
      surfaceContainer: amoled
          ? const Color(0xFF0D0D0D)
          : scheme.surfaceContainer,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: adjustedScheme,
      brightness: brightness,
      scaffoldBackgroundColor: amoled ? Colors.black : null,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: amoled ? Colors.black : null,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: amoled
            ? const Color(0xFF101010)
            : adjustedScheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: amoled
            ? const Color(0xFF101010)
            : adjustedScheme.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: amoled ? Colors.black : null,
        indicatorColor: adjustedScheme.secondaryContainer,
      ),
    );
  }

  static Color readableForeground(Color background) {
    final whiteContrast = contrastRatio(background, Colors.white);
    final blackContrast = contrastRatio(background, Colors.black);
    return whiteContrast >= blackContrast ? Colors.white : Colors.black;
  }

  static double contrastRatio(Color first, Color second) {
    final firstLuminance = first.computeLuminance();
    final secondLuminance = second.computeLuminance();
    final lighter = firstLuminance > secondLuminance
        ? firstLuminance
        : secondLuminance;
    final darker = firstLuminance > secondLuminance
        ? secondLuminance
        : firstLuminance;
    return (lighter + 0.05) / (darker + 0.05);
  }

  static T _enumFromName<T extends Enum>(
    List<T> values,
    String? name,
    T fallback,
  ) {
    for (final value in values) {
      if (value.name == name) return value;
    }
    return fallback;
  }
}
