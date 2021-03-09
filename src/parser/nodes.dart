import '../interpreter/values.dart';

/// Represents each op as a node in the tree.
///
/// The `evaluate()` method contains the logic for performing the ops.
abstract class Node {
  NumberValue evaluate();
}

/// A node which evaluates to a double. It does not perform any math operation
/// but only returns it's `value` from it's `evaluate()` method.
class NumberNode implements Node {
  final double value;

  NumberNode(this.value);

  @override
  String toString() {
    return '$value';
  }

  @override
  NumberValue evaluate() {
    return NumberValue(value);
  }
}

/// A node for ADD operations. It takes two nodes and adds them.
class AddNode implements Node {
  final Node a;
  final Node b;

  AddNode(this.a, this.b);

  @override
  String toString() {
    return '($a+$b)';
  }

  @override
  NumberValue evaluate() {
    return NumberValue(a.evaluate().value + b.evaluate().value);
  }
}

/// A node for SUBTRACT operations. It takes two nodes and subtracts [b] from [a].
class SubtractNode implements Node {
  final Node a;
  final Node b;

  SubtractNode(this.a, this.b);

  @override
  String toString() {
    return '($a-$b)';
  }

  @override
  NumberValue evaluate() {
    return NumberValue(a.evaluate().value - b.evaluate().value);
  }
}

/// A node for MULTIPLY operations. It takes two nodes and multiplies them.
class MultiplyNode implements Node {
  final Node a;
  final Node b;

  MultiplyNode(this.a, this.b);

  @override
  String toString() {
    return '($a*$b)';
  }

  @override
  NumberValue evaluate() {
    return NumberValue(a.evaluate().value * b.evaluate().value);
  }
}

/// A node for DIVIDE operations. It takes two nodes and divides [a] by [b].
class DivideNode implements Node {
  final Node a;
  final Node b;

  DivideNode(this.a, this.b);

  @override
  String toString() {
    return '($a/$b)';
  }

  @override
  NumberValue evaluate() {
    try {
      return NumberValue(a.evaluate().value / b.evaluate().value);
    } on IntegerDivisionByZeroException {
      throw Exception('Cannot divide by zero');
    }
  }
}

/// A node that represents a positive number.
///
/// Eg, when a user types '[+2] - 3'.
class PlusNode implements Node {
  final Node value;

  PlusNode(this.value);

  @override
  String toString() {
    return '+($value)';
  }

  @override
  NumberValue evaluate() {
    return NumberValue(value.evaluate().value);
  }
}

/// A node that performs NEGATION.
///
/// Essentially returns [value * -1].
class MinusNode implements Node {
  final Node value;

  MinusNode(this.value);

  @override
  String toString() {
    return '-($value)';
  }

  @override
  NumberValue evaluate() {
    return NumberValue(-value.evaluate().value);
  }
}
