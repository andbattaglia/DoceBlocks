import 'package:uuid/uuid.dart';

class CustomPage{

  String id;
  String name;
  bool isSelected;

  CustomPage(this.name){
    this.id = Uuid().v1();
    this.isSelected = false;
  }
}