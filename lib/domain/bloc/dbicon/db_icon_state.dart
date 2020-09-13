part of 'db_icon_bloc.dart';


abstract class IconState{
  const IconState();
}

class GetIconSuccess extends IconState {

  final List<DBIcon> icons;

  const GetIconSuccess({@required this.icons});

  @override
  String toString() => 'GetIconsSuccess { ${icons.length} }';
}