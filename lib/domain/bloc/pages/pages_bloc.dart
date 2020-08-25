import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/domain/models/page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:doce_blocks/domain/utils/extensions.dart';

part 'pages_event.dart';
part 'pages_state.dart';

class PagesBloc extends Bloc<PagesEvent, PagesState> {

  //TODO: move it on repository
  List<CustomPage> _pagesList = [ CustomPage("Page 1"), CustomPage("Page 2") ];

  String _selectedId;

  PagesBloc() : super(GetPagesInitial());

  @override
  Stream<PagesState> mapEventToState(PagesEvent event,) async* {

    if(event is GetPagesEvent){
      var pagesList = _pagesList;
      yield GetPagesSuccess(pages: pagesList);

      pagesList.asMap().forEach((index, value) {
        value.isSelected = index == 0;
      });

      yield GetPagesSuccess(pages: pagesList);
    }

    else if(event is SelectPageEvent){
      var pagesList = _pagesList;

      yield GetPagesSuccess(pages: pagesList);

      _selectedId = event.id;
      pagesList.asMap().forEach((index, value) {
        value.isSelected = value.id == _selectedId;
      });

      yield GetPagesSuccess(pages: pagesList);
    }

    else if(event is AddPageEvent){
      var pagesList = _pagesList;
      pagesList.add(CustomPage(event.name));

      pagesList.asMap().forEach((index, value) {
        value.isSelected = value.id == _selectedId;
      });

      yield GetPagesSuccess(pages: pagesList);
    }

    else {
      yield GetPagesInitial();
    }
  }
}





