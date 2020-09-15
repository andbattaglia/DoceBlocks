import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/card_props.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

part 'card_props_event.dart';
part 'card_props_state.dart';

class CardPropsBloc extends Bloc<CardPropsEvent, CardPropsState>{

  CardPropsBloc() : super(GetCardPropsSuccess(props: []));

  @override
  Stream<CardPropsState> mapEventToState(CardPropsEvent event) async* {

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET CARD PROPS EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if(event is GetCardPropsEvent){
      var appRepository = Injector.provideAppRepository();
      var props = await appRepository.getProps();

      yield GetCardPropsSuccess(props: props);
    }
  }
}





