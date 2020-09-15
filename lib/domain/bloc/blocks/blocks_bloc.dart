import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';

part 'blocks_event.dart';
part 'blocks_state.dart';

class BlockBloc extends Bloc<BlocksEvent, BlocksState> {
  BlockBloc() : super(GetBlocksInitial());

  @override
  Stream<BlocksState> mapEventToState(BlocksEvent event) async* {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET PAGES EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (event is GetBlocksEvent) {
      final blockRepository = Injector.provideBlockRepository();
      blockRepository.getBlocks(event.pageId);
    } else {
      yield GetBlocksInitial();
    }
  }
}
