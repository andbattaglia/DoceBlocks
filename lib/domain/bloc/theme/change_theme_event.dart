part of 'change_theme_bloc.dart';

abstract class ChangeThemeEvent extends Equatable {
@override
List<Object> get props => [];
}

class OnThemeChangedEvent extends ChangeThemeEvent {
  final bool lightMode;
  OnThemeChangedEvent(this.lightMode);
  @override
  List<Object> get props => [lightMode];
}
