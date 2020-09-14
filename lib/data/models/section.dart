import 'package:doce_blocks/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Section extends Equatable {
  final String uid;
  final String userId;
  final String name;
  final CustomPageIcon icon;

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
      icon: CustomPageIcon.DESIGN,
      // icon: CustomPageIcon.values.firstWhere((e) => e.toString() == 'CustomPageIcon.' + data["icon"]),
    );

    return section;
  }

  // Section.fromJson(String uid, dynamic data)
  //     : uid = uid,
  //       userId = data["userId"],
  //       name = data["name"],
  //       icon = CustomPageIcon.values.firstWhere((e) => e.toString() == 'CustomPageIcon.' + data["icon"]),
  //       blocks = [],
  //       isSelected = false;

  @override
  List<Object> get props => [uid];

  IconData get materialIcon {
    switch (this.icon) {
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
      default:
        return Icons.apps;
    }
  }
}

enum CustomPageIcon { DEFAULT, BUSINESS, FINANCE, DESIGN, DEVELOPER }
