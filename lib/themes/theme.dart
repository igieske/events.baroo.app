import 'theme_light.dart';
import 'theme_dark.dart';

enum AppTheme {
  light,
  dark,
}

class AppThemes {
  static final appThemeData = {
    AppTheme.light: appThemeLight,
    AppTheme.dark: appThemeDark,
  };
}