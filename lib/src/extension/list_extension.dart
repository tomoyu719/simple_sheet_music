extension IterableExtension on Iterable<double> {
  double get sum => fold(0, (sum, element) => sum + element);
  double get max =>
      fold(first, (max, element) => element > max ? element : max);
  double get min =>
      fold(first, (min, element) => element < min ? element : min);
}
