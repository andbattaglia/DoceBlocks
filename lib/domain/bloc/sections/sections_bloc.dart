import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'sections_event.dart';
part 'sections_state.dart';

class SectionsBloc extends Bloc<SectionsEvent, SectionsState> {
  SectionsBloc() : super(GetSectionsInitial());

  @override
  Stream<SectionsState> mapEventToState(SectionsEvent event) async* {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET PAGES EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (event is GetSectionsEvent) {
      final userRepository = Injector.provideUserRepository();
      final user = await userRepository.getUser();

      final sectionRepository = Injector.provideSectionRepository();
      sectionRepository.getSections(user.uid);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          SELECT PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if (event is SelectSectionEvent) {
      final sectionRepository = Injector.provideSectionRepository();
      sectionRepository.setCurrentSection(event.id);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          ADD PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if (event is AddSectionEvent) {
      var userRepository = Injector.provideUserRepository();
      var user = await userRepository.getUser();

      var appRepository = Injector.provideAppRepository();
      var icon = await appRepository.getSelectedIcon();

      var sectionRepository = Injector.provideSectionRepository();
      sectionRepository.addSection(user.uid, event.name, icon.valueToString);
    }

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          DELETE PAGE EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    else if (event is DeleteSectionEvent) {
      var userRepository = Injector.provideUserRepository();
      var user = await userRepository.getUser();

      var sectionRepository = Injector.provideSectionRepository();
      sectionRepository.deleteSection(user.uid, event.id);
    } else {
      yield GetSectionsInitial();
    }
  }

  ValueStream<List<Section>> getCachedSectionsStream() {
    var sectionRepository = Injector.provideSectionRepository();
    return sectionRepository.observeCachedSections();
  }

  ValueStream<Section> getSelectedSectionStream() {
    var sectionRepository = Injector.provideSectionRepository();
    return sectionRepository.observeSelectedSection();
  }
}
