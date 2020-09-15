part of 'card_props_bloc.dart';

abstract class CardPropsEvent {
  const CardPropsEvent();
}

class GetCardPropsEvent extends CardPropsEvent {

  const GetCardPropsEvent();

  @override
  String toString() => 'GetCardPropsEvent';
}

class SelectCardSizePropEvent extends CardPropsEvent {

  final int propId;

  const SelectCardSizePropEvent({
    @required this.propId,
  });

  @override
  String toString() => 'SelectCardSizePropEvent: ${propId}';
}

class ObserveSelectedPropEvent extends CardPropsEvent {

  const ObserveSelectedPropEvent();

  @override
  String toString() => 'ObserveSelectedPropEvent';
}