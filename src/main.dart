import 'dart:async';
import 'dart:io';

import 'interpreter/interpreter.dart';
import 'lexer/lexer.dart';
import 'parser/parser.dart';

void _preamble() {
  print('=========================================');
  print('Welcome to MATHY! Your Mathematics Friend\n');
  print(
    'Mathy currently supports:\n'
    '* Addition\n'
    '* Subtraction\n'
    '* Multiplication\n'
    '* Division\n'
    '* Brackets\n',
  );
  print("Use 'q' to quit");
  print('=========================================');
}

void _exit() async {
  stdout.write('\nExiting MATHY');

  final timer = Timer.periodic(Duration(milliseconds: 50), (_) {
    stdout.write('.');
  });

  await Future.delayed(Duration(milliseconds: 500), () => timer.cancel());

  stdout.write('\n');
}

void main(List<String> arguments) {
  _preamble();

  while (true) {
    stdout.write('mathy > ');
    final input = stdin.readLineSync();
    // final input = "1+2*6/2";

    if (input.toLowerCase().contains('q')) {
      _exit();
      break;
    }

    final lexer = Lexer(input);
    final tokens = lexer.generateTokens();

    final parser = Parser(tokens);
    final tree = parser.parse();

    if (tree != null) {
      final interpreter = Interpreter();

      try {
        final result = interpreter.interpret(tree);
        print('$result\n');
      } catch (e) {
        print(e);
      }
    }
  }
}
