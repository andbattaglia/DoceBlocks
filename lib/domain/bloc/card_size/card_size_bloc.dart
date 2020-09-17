import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/block.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

part 'card_size_event.dart';
part 'card_size_state.dart';

class CardSizeBloc extends Bloc<CardSizeEvent, CardSizeState> {
  CardSizeBloc() : super(GetCardSizeInitial(values: []));

  @override
  Stream<CardSizeState> mapEventToState(CardSizeEvent event) async* {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET CARD PROPS EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (event is GetCardSizeEvent) {
      final appRepository = Injector.provideAppRepository();
      final values = await appRepository.getCardSizeValues();

      yield GetCardSizeInitial(values: values);
    }

    if (event is SelectCardSizeEvent) {
      final blockRepository = Injector.provideBlockRepository();
      blockRepository.selectCardSize(event.cardSize);
    }
  }
}
