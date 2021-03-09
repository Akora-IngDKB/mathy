import '../tokens/token.dart';

const WHITESPACE = ' \t\n';
const DIGITS = '0123456789';
const DECIMAL_POINT = '.';
const PLUS = '+';
const MINUS = '-';
const MULTIPLY = '*';
const DIVIDE = '/';
const OPEN_BRACKET = '(';
const CLOSE_BRACKET = ')';

/// The [Lexer] takes a list of input string and generates a list of tokens corresponding to each character.
class Lexer {
  final String _text;
  Iterator<String> _iterator;
  String _currentChar;

  Lexer(this._text) {
    // Convert the input string into an [Iterable].
    _iterator = _text.split('').iterator;

    // Advance cursor set the current char to the first element.
    _advance();
  }

  /// Moves the cursor to the next character in the input string.
  void _advance() {
    // Advance cursor to the next element in the input string.
    _iterator.moveNext();

    // Set the current char.
    _currentChar = _iterator.current;
  }

  /// Generates a list of [Token]s from the input string passed to the constructor of the [Lexer].
  List<Token> generateTokens() {
    final tokens = <Token>[];

    while (_currentChar != null) {
      if (WHITESPACE.contains(_currentChar)) {
        _advance();
      } else if (DIGITS.contains(_currentChar) || _currentChar == DECIMAL_POINT) {
        tokens.add(_generateNumberToken());
      } else if (_currentChar == PLUS) {
        tokens.add(Token(TokenType.Plus));
        _advance();
      } else if (_currentChar == MINUS) {
        tokens.add(Token(TokenType.Minus));
        _advance();
      } else if (_currentChar == MULTIPLY) {
        tokens.add(Token(TokenType.Multiply));
        _advance();
      } else if (_currentChar == DIVIDE) {
        tokens.add(Token(TokenType.Divide));
        _advance();
      } else if (_currentChar == OPEN_BRACKET) {
        tokens.add(Token(TokenType.OpenBracket));
        _advance();
      } else if (_currentChar == CLOSE_BRACKET) {
        tokens.add(Token(TokenType.CloseBracket));
        _advance();
      }
    }

    return tokens;
  }

  Token _generateNumberToken() {
    var numString = _currentChar;
    var decimalPointCount = 0; // To track the number of decimal points

    _advance();

    while (_currentChar != null && DIGITS.contains(_currentChar) || _currentChar == DECIMAL_POINT) {
      if (_currentChar == DECIMAL_POINT) {
        decimalPointCount++;

        if (decimalPointCount > 1) {
          break;
        }
      }
      numString += _currentChar;
      _advance();
    }

    // Append leading 0 in input events such as '.123'
    if (numString.startsWith('.')) {
      numString = '0' + numString;
    }

    // Append trailing 0 in input events such as '123.'
    if (numString.endsWith('.')) {
      numString += '0';
    }

    return Token(TokenType.Number, value: double.parse(numString));
  }
}
