import 'package:doce_blocks/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class CustomPage extends Equatable {

  String userId;
  String uid;
  String name;
  bool isSelected;
//  List<Block> blocks;

  CustomPage(
      this.userId,
      this.uid,
      this.name,
//      { @required this.blocks, }
  ){
    this.isSelected = false;
  }

  CustomPage.fromJson(String uid, dynamic data)
      : uid = uid,
        userId = data["userId"],
        name = data["name"],
        isSelected = false;
//        blocks = (data["blocks"] as List).map(CardBlock.fromJson).toList();

  @override
  List<Object> get props => [uid];
}
