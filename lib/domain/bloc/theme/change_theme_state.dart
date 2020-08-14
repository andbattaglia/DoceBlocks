part of 'change_theme_bloc.dart';

abstract class ChangeThemeState extends Equatable {
  final ThemeState themeState;

  ChangeThemeState(this.themeState);

  @override
  List<Object> get props => [themeState];
}

class ChangeThemeLight extends ChangeThemeState {
  static final state = ThemeState.light();
  ChangeThemeLight() : super(state);
}

class ChangeThemeDark extends ChangeThemeState {
  static final state = ThemeState.dark();
  ChangeThemeDark() : super(state);
}



class ThemeState extends Equatable{

  final bool isLightMode;
  final ThemeMode themeMode;

  const ThemeState(this.isLightMode, this.themeMode);

  factory ThemeState.light() {
    return ThemeState(true, ThemeMode.light);
  }

  factory ThemeState.dark() {
    return ThemeState(false, ThemeMode.dark);
  }

  @override
  List<Object> get props => [isLightMode,themeMode];
}
