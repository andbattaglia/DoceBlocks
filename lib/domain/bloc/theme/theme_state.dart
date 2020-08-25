part of 'theme_bloc.dart';

abstract class SettingsThemeState extends Equatable {
  final ThemeState themeState;

  SettingsThemeState(this.themeState);

  @override
  List<Object> get props => [themeState];
}

class ChangeThemeLight extends SettingsThemeState {
  static final state = ThemeState.light();
  ChangeThemeLight() : super(state);
}

class ChangeThemeDark extends SettingsThemeState {
  static final state = ThemeState.dark();
  ChangeThemeDark() : super(state);
}



class ThemeState extends Equatable{

  final bool isDarkMode;
  final ThemeMode themeMode;

  const ThemeState(this.isDarkMode, this.themeMode);

  factory ThemeState.light() {
    return ThemeState(false, ThemeMode.light);
  }

  factory ThemeState.dark() {
    return ThemeState(true, ThemeMode.dark);
  }

  @override
  List<Object> get props => [isDarkMode,themeMode];
}
