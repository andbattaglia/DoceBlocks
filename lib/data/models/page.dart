import 'package:doce_blocks/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class CustomPage extends Equatable {

  String userId;
  String uid;
  String name;
  CustomPageIcon icon;
  bool isSelected;
//  List<Block> blocks;

  CustomPage(
      this.userId,
      this.uid,
      this.name,
      this.icon,
//      { @required this.blocks, }
  ){
    this.isSelected = false;
  }

  CustomPage.fromJson(String uid, dynamic data)
      : uid = uid,
        userId = data["userId"],
        name = data["name"],
        icon = CustomPageIcon.values.firstWhere((e) => e.toString() == 'CustomPageIcon.' + data["icon"]),
        isSelected = false;
//        blocks = (data["blocks"] as List).map(CardBlock.fromJson).toList();

  @override
  List<Object> get props => [uid];

  IconData get materialIcon {
    switch(this.icon){
      case CustomPageIcon.DEFAULT:
        return Icons.apps;
        case CustomPageIcon.BUSINESS:
        return Icons.business;
      case CustomPageIcon.FINANCE:
        return Icons.account_balance;
      case CustomPageIcon.DESIGN:
        return Icons.color_lens;
      case CustomPageIcon.DEVELOPER:
        return Icons.developer_mode;
    }
  }
}

enum CustomPageIcon {
  DEFAULT,
  BUSINESS,
  FINANCE,
  DESIGN,
  DEVELOPER
}