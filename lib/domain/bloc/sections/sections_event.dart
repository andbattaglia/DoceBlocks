part of 'sections_bloc.dart';

abstract class SectionsEvent {
  const SectionsEvent();
}

class GetSectionsEvent extends SectionsEvent {
  const GetSectionsEvent();

  @override
  String toString() => 'GetSectionsEvent';
}

class SelectSectionEvent extends SectionsEvent {
  final String id;

  const SelectSectionEvent({
    @required this.id,
  });

  @override
  String toString() => 'SelectSectionEvent ${this.id}';
}

class AddSectionEvent extends SectionsEvent {
  final String name;

  const AddSectionEvent({
    @required this.name,
  });

  @override
  String toString() => 'AddSectionEvent ${this.name}';
}

class DeleteSectionEvent extends SectionsEvent {
  final String id;

  const DeleteSectionEvent({
    @required this.id,
  });

  @override
  String toString() => 'DeleteSectionEvent ${this.id}';
}
