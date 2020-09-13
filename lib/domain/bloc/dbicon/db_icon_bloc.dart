import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/icon.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'db_icon_event.dart';
part 'db_icon_state.dart';

class IconBloc extends Bloc<IconEvent, IconState> {

  IconBloc() : super(GetIconSuccess(icons: []));

  @override
  Stream<IconState> mapEventToState(IconEvent event) async* {

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET ICON EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(event is GetIconsEvent){
      var appRepository = Injector.provideAppRepository();
      var icons = await appRepository.getIcons();

      yield GetIconSuccess(icons: icons);
    }

    if(event is SelectIconEvent){
      var appRepository = Injector.provideAppRepository();
      appRepository.selectIcon(event.iconId);
    }
  }

  ValueStream<DBIcon> getSelectedIconStream() {
      var appRepository = Injector.provideAppRepository();
      return appRepository.observeSelectedIcon();
  }
}





