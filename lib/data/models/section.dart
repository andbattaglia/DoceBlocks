import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Section extends Equatable {
  final String uid;
  final String userId;
  final String name;
  final String icon;

  bool isSelected;

  Section(
    this.uid, {
    @required this.userId,
    @required this.name,
    @required this.icon,
  }) {
    this.isSelected = false;
  }

  static Section fromJson(String uid, dynamic data) {
    final section = new Section(
      uid,
      userId: data["userId"],
      name: data["name"],
      icon: data["icon"],
    );

    return section;
  }

  @override
  List<Object> get props => [uid];

  IconData get materialIcon {
    switch (this.icon) {
      case "BUSINESS":
        return Icons.business;
      case "FINANCE":
        return Icons.account_balance;
      case "DESIGN":
        return Icons.color_lens;
      case "DEVELOPER":
        return Icons.developer_mode;
      default:
        return Icons.apps;
    }
  }
}
