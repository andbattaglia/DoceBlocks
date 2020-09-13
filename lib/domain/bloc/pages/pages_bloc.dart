import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

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
      var pages = await pageRepository.getPages(user.uid, false);

      yield GetPagesSuccess(pages: pages);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          SELECT PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if(event is SelectPageEvent){
      var userRepository = Injector.provideUserRepository();
      var user = await userRepository.getUser();

      var pageRepository = Injector.providePageRepository();
      var pages = await pageRepository.getPages(user.uid, true);
      yield GetPagesSuccess(pages: pages);

      pages = pageRepository.setCurrentPage(event.id);
      yield GetPagesSuccess(pages: pages);
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
      await pageRepository.setPage(user.uid, event.name, icon.valueToString);

      var pages = await pageRepository.getPages(user.uid, false);
      yield GetPagesSuccess(pages: pages);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          DELETE PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if(event is DeletePageEvent){
      var userRepository = Injector.provideUserRepository();
      var user = await userRepository.getUser();

      var pageRepository = Injector.providePageRepository();
      await pageRepository.deletePages(event.id);

      var pages = await pageRepository.getPages(user.uid, false);
      yield GetPagesSuccess(pages: pages);
    }


    else {
      yield GetPagesInitial();
    }
  }
}





