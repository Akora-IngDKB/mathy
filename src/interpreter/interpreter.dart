import '../parser/nodes.dart';

class Interpreter {
  double interpret(Node node) {
    return node.evaluate().value;
  }
}
