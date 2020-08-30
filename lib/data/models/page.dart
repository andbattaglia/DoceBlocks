import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  static Block fromJson(dynamic json) {
    final String type = json["type"] as String;

    switch (type) {
      case "video":
        return VideoBlock.fromJson(json);

      case "image":
        return ImageBlock.fromJson(json);

      case "card":
        return CardBlock.fromJson(json);

      case "list":
        return ListBlock.fromJson(json);

      default:
        return UnknownBlock.fromJson(json);
    }
  }

  @override
  List<Object> get props => [uid, type];
}

@immutable
class UnknownBlock extends Block {
  UnknownBlock(final String uid) : super(uid, BlockType.VIDEO);

  static UnknownBlock fromJson(dynamic json) {
    return UnknownBlock(json["uid"] as String);
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

  static VideoBlock fromJson(dynamic json) {
    return VideoBlock(
      json["uid"] as String,
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

  static ImageBlock fromJson(dynamic json) {
    return ImageBlock(
      json["uid"] as String,
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

  static CardBlock fromJson(dynamic json) {
    return CardBlock(
      json["uid"] as String,
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

  static ListBlock fromJson(dynamic json) {
    return ListBlock(
      json["uid"] as String,
      cards: (json["cards"] as List).map(CardBlock.fromJson).toList(),
    );
  }

  @override
  List<Object> get props => [uid, type, cards];
}

@immutable
class Page extends Equatable {
  final String uid;
  final List<Block> blocks;

  Page(
    this.uid, {
    @required this.blocks,
  });

  Page.fromJson(String uid, final dynamic data)
      : uid = uid,
        blocks = (data["blocks"] as List).map(CardBlock.fromJson).toList();

  @override
  List<Object> get props => [uid];
}
