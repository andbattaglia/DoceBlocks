import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum BlockType {
  UNKNOWN,
  VIDEO,
  IMAGE,
  CARD,
  LIST,
}

extension BlockTypeString on BlockType {
  String get tag => describeEnum(this);
}

@immutable
abstract class Block extends Equatable {
  final String uid;
  final BlockType type;

  const Block(this.uid, this.type);

  static Block fromJson(String uid, dynamic json) {
    final String type = json["type"] as String;

    switch (type) {
      case "video":
        return VideoBlock.fromJson(uid, json);

      case "image":
        return ImageBlock.fromJson(uid, json);

      case "card":
        return CardBlock.fromJson(uid, json);

      case "list":
        return ListBlock.fromJson(uid, json);

      default:
        return UnknownBlock.fromJson(uid, json);
    }
  }

  @override
  List<Object> get props => [uid, type];
}

@immutable
class UnknownBlock extends Block {
  UnknownBlock(final String uid) : super(uid, BlockType.VIDEO);

  static UnknownBlock fromJson(String uid, dynamic json) {
    return UnknownBlock(uid);
  }

  @override
  List<Object> get props => [uid, type];
}

@immutable
class VideoBlock extends Block {
  final String url;

  VideoBlock(
    final String uid, {
    @required this.url,
  }) : super(uid, BlockType.VIDEO);

  static VideoBlock fromJson(String uid, dynamic json) {
    return VideoBlock(
      uid,
      url: json["url"] as String,
    );
  }

  @override
  List<Object> get props => [uid, type, url];
}

@immutable
class ImageBlock extends Block {
  final String url;

  ImageBlock(
    final String uid, {
    @required this.url,
  }) : super(uid, BlockType.IMAGE);

  static ImageBlock fromJson(String uid, dynamic json) {
    return ImageBlock(
      uid,
      url: json["url"] as String,
    );
  }

  @override
  List<Object> get props => [uid, type, url];
}

@immutable
class CardBlock extends Block {
  final String url;
  final String title;
  final String description;

  CardBlock(
    final String uid, {
    @required this.url,
    @required this.title,
    @required this.description,
  }) : super(uid, BlockType.CARD);

  static CardBlock fromJson(String uid, dynamic json) {
    return CardBlock(
      uid,
      url: json["url"] as String,
      title: json["title"] as String,
      description: json["description"] as String,
    );
  }

  @override
  List<Object> get props => [uid, type, url, title, description];
}

class ListBlock extends Block {
  final List<CardBlock> cards;

  ListBlock(
    final String uid, {
    @required this.cards,
  }) : super(uid, BlockType.VIDEO);

  static ListBlock fromJson(String uid, dynamic json) {
    return ListBlock(
      uid,
      cards: (json["cards"] as List).map((card) => CardBlock.fromJson(uid, card)).toList(),
    );
  }

  @override
  List<Object> get props => [uid, type, cards];
}
