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
  final String pageId;

  const GetBlocksEvent({
    @required this.pageId,
  });

  @override
  String toString() => 'GetBlocksEvent ${this.pageId}';
}
