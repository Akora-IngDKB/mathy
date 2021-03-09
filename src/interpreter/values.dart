/// The return value of the `evaluate()` method of a [Node].
class NumberValue {
  final double value;

  NumberValue(this.value);

  @override
  String toString() {
    return '$value';
  }
}
