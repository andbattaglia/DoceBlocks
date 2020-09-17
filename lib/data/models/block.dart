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

enum CardSize {
  get,
  BIG,
  SMALL,
}

extension CardSizeString on CardSize {
  String get tag => describeEnum(this);

  operator [](String key) => (String name) {
        switch (name.toLowerCase()) {
          case 'big':
            return CardSize.BIG;
          case 'small':
            return CardSize.SMALL;
          default:
            throw RangeError("enum CardSize contains no value '$name'");
        }
      }(key);
}

@immutable
abstract class Block extends Equatable {
  final String uid;
  final List<String> sections;
  final BlockType type;

  const Block({
    this.uid,
    @required this.type,
    this.sections,
  });

  static Block fromSnapshot(DocumentSnapshot snap) {
    return Block.fromJson(snap.documentID, snap.data);
  }

  static Block fromJson(String uid, Map<String, Object> json) {
    final String type = json["type"] as String;

    switch (type.toLowerCase()) {
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
    List<String> sections,
  }) : super(uid: uid, type: BlockType.UNKNOWN, sections: sections);

  static UnknownBlock fromJson(String uid, dynamic json) {
    return UnknownBlock(uid: uid);
  }

  @override
  List<Object> get props => [uid, type];

  @override
  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "sections": this.sections,
    };
  }
}

@immutable
class VideoBlock extends Block {
  final String url;

  VideoBlock({
    final String uid,
    @required this.url,
    final List<String> sections,
  }) : super(uid: uid, type: BlockType.VIDEO, sections: sections);

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
      "sections": this.sections,
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
    final List<String> sections,
  }) : super(uid: uid, type: BlockType.IMAGE, sections: sections);

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
      "sections": this.sections,
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
  CardSize size;

  CardBlock({
    final String uid,
    @required this.url,
    @required this.title,
    @required this.description,
    @required this.thumbUrl,
    this.size,
    final List<String> sections,
  }) : super(uid: uid, type: BlockType.CARD, sections: sections);

  static CardBlock fromJson(String uid, dynamic json) {
    return CardBlock(
      uid: uid,
      url: json["url"] as String,
      title: json["title"] as String,
      description: json["description"] as String,
      thumbUrl: json["thumbnail_url"] as String,
      size: CardSize.get[json["size"] as String],
    );
  }

  @override
  List<Object> get props => [uid, type, url, title, description];

  @override
  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "sections": this.sections,
      "url": this.url,
      "title": this.title,
      "description": this.description,
      "thumbnail_url": this.thumbUrl,
      "size": this.size.tag,
    };
  }
}

class ListBlock extends Block {
  final List<CardBlock> cards;

  ListBlock({
    final String uid,
    @required this.cards,
    final List<String> sections,
  }) : super(uid: uid, type: BlockType.VIDEO, sections: sections);

  static ListBlock fromJson(String uid, dynamic json) {
    return ListBlock(
      uid: uid,
      cards: (json["cards"] as List)
          .map((card) => CardBlock.fromJson(uid, card))
          .toList(),
    );
  }

  @override
  List<Object> get props => [uid, type, cards];

  Map<String, Object> _toDocument() {
    return {
      "type": this.type.tag,
      "sections": this.sections,
      "cards": [], //TODO:
    };
  }
}
