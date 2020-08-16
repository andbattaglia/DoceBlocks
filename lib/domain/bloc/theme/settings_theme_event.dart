part of 'settings_theme_bloc.dart';

abstract class SettingsThemeEvent extends Equatable {
@override
List<Object> get props => [];
}

class OnSettingsThemeChangedEvent extends SettingsThemeEvent {
  final bool isDarkMode;
  OnSettingsThemeChangedEvent(this.isDarkMode);
  @override
  List<Object> get props => [isDarkMode];
}
