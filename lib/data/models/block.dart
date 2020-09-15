import 'package:cloud_firestore/cloud_firestore.dart';
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
  final List<String> pages;
  final BlockType type;

  const Block({
    this.uid,
    @required this.type,
    this.pages,
  });

  static Block fromSnapshot(DocumentSnapshot snap) {
    return Block.fromJson(snap.documentID, snap.data);
  }

  static Block fromJson(String uid, Map<String, Object> json) {
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

  static Map<String, Object> toDocument(Block block) {
    return block._toDocument();
  }

  Map<String, Object> _toDocument();

  @override
  List<Object> get props => [uid, type];
}

@immutable
class UnknownBlock extends Block {
  UnknownBlock({
    String uid,
    List<String> pages,
  }) : super(uid: uid, type: BlockType.UNKNOWN, pages: pages);

  static UnknownBlock fromJson(String uid, dynamic json) {
    return UnknownBlock(uid: uid);
  }

  @override
  List<Object> get props => [uid, type];

  @override
  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "pages": this.pages,
    };
  }
}

@immutable
class VideoBlock extends Block {
  final String url;

  VideoBlock({
    final String uid,
    @required this.url,
    final List<String> pages,
  }) : super(uid: uid, type: BlockType.VIDEO, pages: pages);

  static VideoBlock fromJson(String uid, dynamic json) {
    return VideoBlock(
      uid: uid,
      url: json["url"] as String,
    );
  }

  @override
  List<Object> get props => [uid, type, url];

  @override
  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "pages": this.pages,
      "url": this.url,
    };
  }
}

@immutable
class ImageBlock extends Block {
  final String url;

  ImageBlock({
    final String uid,
    @required this.url,
    final List<String> pages,
  }) : super(uid: uid, type: BlockType.IMAGE, pages: pages);

  static ImageBlock fromJson(String uid, dynamic json) {
    return ImageBlock(
      uid: uid,
      url: json["url"] as String,
    );
  }

  @override
  List<Object> get props => [uid, type, url];

  @override
  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "pages": this.pages,
      "url": this.url,
    };
  }
}

@immutable
class CardBlock extends Block {
  final String url;
  final String title;
  final String description;
  final String thumbUrl;

  CardBlock({
    final String uid,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.thumbUrl,
    final List<String> pages,
  }) : super(uid: uid, type: BlockType.CARD, pages: pages);

  static CardBlock fromJson(String uid, dynamic json) {
    return CardBlock(
      uid: uid,
      url: json["url"] as String,
      title: json["title"] as String,
      description: json["description"] as String,
      thumbUrl: json["thumbnail_url"] as String,
    );
  }

  @override
  List<Object> get props => [uid, type, url, title, description];

  @override
  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "pages": this.pages,
      "url": this.url,
      "title": this.title,
      "description": this.description,
      "thumbnail_url": this.thumbUrl,
    };
  }
}

class ListBlock extends Block {
  final List<CardBlock> cards;

  ListBlock({
    final String uid,
    @required this.cards,
    final List<String> pages,
  }) : super(uid: uid, type: BlockType.VIDEO, pages: pages);

  static ListBlock fromJson(String uid, dynamic json) {
    return ListBlock(
      uid: uid,
      cards: (json["cards"] as List).map((card) => CardBlock.fromJson(uid, card)).toList(),
    );
  }

  @override
  List<Object> get props => [uid, type, cards];

  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "pages": this.pages,
      "cards": [], //TODO:
    };
  }
}
