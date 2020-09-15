part of 'blocks_bloc.dart';

abstract class BlocksEvent {
  const BlocksEvent();
}

class GetBlocksEvent extends BlocksEvent {
  final String pageId;

  const GetBlocksEvent({
    @required this.pageId,
  });

  @override
  String toString() => 'GetBlocksEvent ${this.pageId}';
}
