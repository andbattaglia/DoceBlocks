part of 'card_props_bloc.dart';


abstract class CardPropsState{
  const CardPropsState();
}

class GetCardPropsSuccess extends CardPropsState {

  final List<CardProps> props;

  const GetCardPropsSuccess({@required this.props});

  @override
  String toString() => 'GetCardPropsSuccess { ${props.length} }';
}