import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class DBIcon extends Equatable {

  String name;
  IconValue value;

  DBIcon(
      this.name,
      this.value
  );

  @override
  List<Object> get props => [name, value];

  IconData get mapToIcon {
    switch(this.value){
      case IconValue.DEFAULT:
        return Icons.apps;
      case IconValue.BUSINESS:
        return Icons.business;
      case IconValue.FINANCE:
        return Icons.account_balance;
      case IconValue.DESIGN:
        return Icons.color_lens;
      case IconValue.DEVELOPER:
        return Icons.developer_mode;
    }
  }

  static List<DBIcon> generateIcons(){
    return [
      DBIcon("Default", IconValue.DEFAULT),
      DBIcon("Business", IconValue.BUSINESS),
      DBIcon("Finance", IconValue.FINANCE),
      DBIcon("Design", IconValue.DESIGN),
      DBIcon("Developer", IconValue.DEVELOPER)
    ];
  }
}

enum IconValue {
  DEFAULT,
  BUSINESS,
  FINANCE,
  DESIGN,
  DEVELOPER
}