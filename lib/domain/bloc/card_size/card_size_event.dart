part of 'card_size_bloc.dart';

abstract class CardSizeEvent {
  const CardSizeEvent();
}

class GetCardSizeEvent extends CardSizeEvent {
  const GetCardSizeEvent();

  @override
  String toString() => 'GetCardSizeEvent';
}

class SelectCardSizeEvent extends CardSizeEvent {
  final CardSize cardSize;

  const SelectCardSizeEvent({
    @required this.cardSize,
  });

  @override
  String toString() => 'SelectCardSizeEvent: ${cardSize.tag}';
}
