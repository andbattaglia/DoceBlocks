import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/domain/utils/const.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class SettingsThemeBloc extends Bloc<SettingsThemeEvent, SettingsThemeState> {

  SettingsThemeBloc() : super(ChangeThemeLight());

  @override
  Stream<SettingsThemeState> mapEventToState(SettingsThemeEvent event) async* {
    if (event is OnSettingsThemeChangedEvent) {
      yield* _onChangedSettingTheme(event.isDarkMode);
    }
  }

  Stream<SettingsThemeState> _onChangedSettingTheme(bool isDarkMode) async* {
    if (isDarkMode) {
      yield ChangeThemeDark();
      try {
        _saveOptionValue(1);
      } catch (_) {
        throw Exception("Could not persist change");
      }
    } else {
      yield ChangeThemeLight();
      try {
        _saveOptionValue(0);
      } catch (_) {
        throw Exception("Could not persist change");
      }
    }
  }

  Future<Null> _saveOptionValue(int optionValue) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(Const.KEY_SETTING_THEME, optionValue);
  }

  Future<int> getOption() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int option = preferences.get(Const.KEY_SETTING_THEME) ?? 0;
    return option;
  }

  Future<SettingsThemeState> initialState() async{
    return await getOption() == 0 ? ChangeThemeLight() : ChangeThemeDark();
  }
}
