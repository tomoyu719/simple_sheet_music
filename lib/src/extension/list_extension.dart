extension IterableExtension on Iterable<double> {
  /// Returns the sum of all elements in the iterable.
  double get sum => fold(0, (sum, element) => sum + element);

  /// Returns the maximum value in the iterable. Throws a [StateError] if the iterable is empty.
  double get max =>
      fold(first, (max, element) => element > max ? element : max);

  /// Returns the minimum value in the iterable. Throws a [StateError] if the iterable is empty.
  double get min =>
      fold(first, (min, element) => element < min ? element : min);
}
