part of 'card_size_bloc.dart';

abstract class CardSizeEvent {
  const CardSizeEvent();
}

class GetCardSizeEvent extends CardSizeEvent {
  const GetCardSizeEvent();

  @override
  String toString() => 'GetCardSizeEvent';
}
