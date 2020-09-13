import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'pages_event.dart';
part 'pages_state.dart';

class PagesBloc extends Bloc<PagesEvent, PagesState> {

  PagesBloc() : super(GetPagesInitial());

  @override
  Stream<PagesState> mapEventToState(PagesEvent event) async* {

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET PAGES EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(event is GetPagesEvent){
      var userRepository = Injector.provideUserRepository();
      var user = await userRepository.getUser();

      var pageRepository = Injector.providePageRepository();
      pageRepository.getPages(user.uid);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          SELECT PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if(event is SelectPageEvent){
      var pageRepository = Injector.providePageRepository();
      pageRepository.setCurrentPage(event.id);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          ADD PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if(event is AddPageEvent){
      var userRepository = Injector.provideUserRepository();
      var user = await userRepository.getUser();

      var appRepository = Injector.provideAppRepository();
      var icon = await appRepository.getSelectedIcon();

      var pageRepository = Injector.providePageRepository();
      pageRepository.addPage(user.uid, event.name, icon.valueToString);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          DELETE PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if(event is DeletePageEvent){
      var userRepository = Injector.provideUserRepository();
      var user = await userRepository.getUser();

      var pageRepository = Injector.providePageRepository();
      pageRepository.deletePages(user.uid, event.id);
    }

    else {
      yield GetPagesInitial();
    }
  }

  ValueStream<List<CustomPage>> getCachedPageStream() {
    var appRepository = Injector.providePageRepository();
    return appRepository.observeCachedPages();
  }

  ValueStream<CustomPage> getSelectedPageStream() {
    var appRepository = Injector.providePageRepository();
    return appRepository.observeSelectedPages();
  }
}





