part of 'card_size_bloc.dart';

abstract class CardSizeState {
  const CardSizeState();
}

class GetCardSizeInitial extends CardSizeState {
  final List<CardSize> values;

  const GetCardSizeInitial({
    @required this.values,
  });

  @override
  String toString() => 'GetCardSizeInitial { ${values.length} }';
}
