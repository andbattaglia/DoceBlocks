import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'blocks_event.dart';
part 'blocks_state.dart';

class BlocksBloc extends Bloc<BlocksEvent, BlocksState> {
  BlocksBloc() : super(GetBlocksInitial());

  @override
  Stream<BlocksState> mapEventToState(BlocksEvent event) async* {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //          GET PAGES EVENT
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (event is GetBlocksEvent) {
      final blockRepository = Injector.provideBlockRepository();
      blockRepository.getBlocks(event.sectionId);
    }

    if (event is AddBlocksEvent) {
      final blockRepository = Injector.provideBlockRepository();
      final sectionRepository = Injector.provideSectionRepository();
      final selectedSectionId = sectionRepository.getSelectedSectionId();
      final blocks = event.blocks.map((block) {
        block.sections.add(selectedSectionId);
        return block;
      }).toList();

      blockRepository.addBlocks(blocks);
    }

    if (event is AddCardBlockEvent) {
      final blockRepository = Injector.provideBlockRepository();
      final sectionRepository = Injector.provideSectionRepository();
      final selectedSectionId = sectionRepository.getSelectedSectionId();
      final block = event.block;
      block.sections.add(selectedSectionId);
      blockRepository.addCardBlock(block);
    }

    if (event is DeleteBlockEvent) {
      final blockRepository = Injector.provideBlockRepository();
      final sectionRepository = Injector.provideSectionRepository();
      final selectedSectionId = sectionRepository.getSelectedSectionId();
      blockRepository.deleteBlock(selectedSectionId, event.blockId);
    }

    if (event is SyncDoceboCatalogEvent) {
      final blockRepository = Injector.provideBlockRepository();
      final sectionRepository = Injector.provideSectionRepository();
      final selectedSectionId = sectionRepository.getSelectedSectionId();
      blockRepository.syncDoceboCatalog(selectedSectionId);
    }
  }

  ValueStream<List<Block>> getBlocksStream() {
    var blockRepository = Injector.provideBlockRepository();
    return blockRepository.observeCachedBlocks();
  }

  ValueStream<CardSize> getSelectedCardSizeStream() {
    var blockRepository = Injector.provideBlockRepository();
    return blockRepository.observeSelectedCardSize();
  }
}
