import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//TODO: [nichel]: fix enum

@immutable
class DBIcon extends Equatable {
  int id;
  String name;
  IconValue value;

  DBIcon(this.id, this.name, this.value);

  @override
  List<Object> get props => [id, name, value];

  String get valueToString {
    return value.toString().substring(value.toString().indexOf('.') + 1);
  }

  IconData get mapToIcon {
    switch (this.value) {
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

  static List<DBIcon> generateIcons() {
    return [
      DBIcon(0, "Default", IconValue.DEFAULT),
      DBIcon(1, "Business", IconValue.BUSINESS),
      DBIcon(2, "Finance", IconValue.FINANCE),
      DBIcon(3, "Design", IconValue.DESIGN),
      DBIcon(4, "Developer", IconValue.DEVELOPER),
    ];
  }
}

enum IconValue { DEFAULT, BUSINESS, FINANCE, DESIGN, DEVELOPER }
