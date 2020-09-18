part of 'blocks_bloc.dart';

abstract class BlocksEvent {
  const BlocksEvent();
}

class AddBlocksEvent extends BlocksEvent {
  final List<Block> blocks;

  const AddBlocksEvent({
    @required this.blocks,
  });

  @override
  String toString() => 'AddBlocksEvent ${this.blocks}';
}

class AddCardBlockEvent extends BlocksEvent {
  final CardBlock block;

  const AddCardBlockEvent({
    @required this.block,
  });

  @override
  String toString() => 'AddCardBlockEvent ${this.block}';
}

class GetBlocksEvent extends BlocksEvent {
  final String sectionId;

  const GetBlocksEvent({
    @required this.sectionId,
  });

  @override
  String toString() => 'GetBlocksEvent ${this.sectionId}';
}

class SyncDoceboCatalogEvent extends BlocksEvent {
  const SyncDoceboCatalogEvent();

  @override
  String toString() => 'SyncDoceboCatalogEvent';
}

class DeleteBlockEvent extends BlocksEvent {
  final String blockId;

  const DeleteBlockEvent({
    @required this.blockId,
  });

  @override
  String toString() => 'DeleteBlockEvent ${this.blockId}';
}
