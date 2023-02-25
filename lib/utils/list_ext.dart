extension ListExt<T> on List<T> {
  List<T> toggled(T element) {
    if (contains(element)) {
      return where((e) => e != element).toList();
    } else {
      return [...this, element];
    }
  }
}
