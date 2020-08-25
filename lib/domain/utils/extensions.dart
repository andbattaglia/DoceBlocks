extension ListUpdate<T> on List {
  List update(int pos, T t) {
    List<T> list = new List();
    list.add(t);
    replaceRange(pos, pos + 1, list);
    return this;
  }
}