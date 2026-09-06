import 'package:flutter_test/flutter_test.dart';
import 'package:killqr/core/theme/app_theme.dart';

void main() {
  test('generated themes maintain readable primary foreground contrast', () {
    final settings = AppSettingsController();
    for (final theme in <dynamic>[
      settings.lightTheme(),
      settings.darkTheme(),
      settings.amoledTheme(),
    ]) {
      expect(
        AppSettingsController.contrastRatio(
          theme.colorScheme.primary,
          theme.colorScheme.onPrimary,
        ),
        greaterThanOrEqualTo(4.5),
      );
    }
    expect(settings.amoledTheme().scaffoldBackgroundColor, isNotNull);
  });
}
