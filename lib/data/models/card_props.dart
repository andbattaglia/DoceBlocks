import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class CardProps extends Equatable {

  int id;
  String name;
  CardPropsSize size;

  CardProps(
      this.id,
      this.name,
      this.size
  );

  @override
  List<Object> get props => [id, name, size];

  String get sizeToString{
    return size.toString().substring(size.toString().indexOf('.') +1 );
  }

  static List<CardProps> generateProps(){
    return [
      CardProps(0, "Big", CardPropsSize.BIG),
      CardProps(1, "Small", CardPropsSize.SMALL)
    ];
  }
}

enum CardPropsSize {
  BIG,
  SMALL
}