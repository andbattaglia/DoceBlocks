part of 'pages_bloc.dart';

abstract class PagesState{
  const PagesState();
}

class GetPagesInitial extends PagesState {}

class GetPagesSuccess extends PagesState {
  final List<CustomPage> pages;

  const GetPagesSuccess({@required this.pages});

  @override
  String toString() => 'PagesSuccess { ${pages.length} }';
}