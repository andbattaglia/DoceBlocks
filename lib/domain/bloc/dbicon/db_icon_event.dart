part of 'db_icon_bloc.dart';

abstract class IconEvent {
  const IconEvent();
}

class GetIconsEvent extends IconEvent {

  const GetIconsEvent();

  @override
  String toString() => 'GetIconsEvent';
}

class SelectIconEvent extends IconEvent {

  final int iconId;

  const SelectIconEvent({
    @required this.iconId,
  });

  @override
  String toString() => 'SelectIconEvent: ${iconId}';
}

class ObserveSelectedIconEvent extends IconEvent {

  const ObserveSelectedIconEvent();

  @override
  String toString() => 'ObserveSelectedIconEvent';
}