part of 'pages_bloc.dart';

abstract class PagesEvent {
  const PagesEvent();
}

class GetPagesEvent extends PagesEvent {

  const GetPagesEvent();

  @override
  String toString() => 'GetPagesEvent';
}

class SelectPageEvent extends PagesEvent {

  final String id;

  const SelectPageEvent({
    @required this.id,
  });

  @override
  String toString() => 'SelectPageEvent ${this.id}';
}

class AddPageEvent extends PagesEvent {

  final String name;

  const AddPageEvent({
    @required this.name,
  });

  @override
  String toString() => 'AddPageEvent ${this.name}';
}

class DeletePageEvent extends PagesEvent {

  final String id;

  const DeletePageEvent({
    @required this.id,
  });

  @override
  String toString() => 'DeletePageEvent ${this.id}';
}