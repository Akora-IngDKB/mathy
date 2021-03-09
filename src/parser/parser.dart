import '../tokens/token.dart';
import 'nodes.dart';

/// Factors look for number tokens.
///
/// Terms look for multiply and divide. Factor */ Factor
///
/// Expression looks for plus and minus ops which is sided by two terms. Term +- Term

class Parser {
  Parser(this._tokens) {
    _iterator = _tokens.iterator;

    _advance();
  }

  final List<Token> _tokens;

  Iterator<Token> _iterator;
  Token _currentToken;

  void _advance() {
    _iterator.moveNext();

    _currentToken = _iterator.current;
  }

  /// Traverses through a list of [Token]s and build a tree of [Node]s which represents
  /// different ops.
  ///
  /// Eg, for an input '1 + 2 * 3', a tree will be built like so:
  ///
  ///         +
  ///     1       *
  ///           2   3
  Node parse() {
    if (_currentToken == null) {
      return null;
    }

    final result = _expression();

    if (_currentToken != null) {
      throw Exception('Syntax error');
    }

    return result;
  }

  // Builds a subtree for ADD and SUBTRACT Ops which generally requires two terms, say a and b.
  Node _expression() {
    var result = _term();

    while (_currentToken != null && [TokenType.Plus, TokenType.Minus].contains(_currentToken.type)) {
      if (_currentToken.type == TokenType.Plus) {
        _advance();
        result = AddNode(result, _term());
      } else if (_currentToken.type == TokenType.Minus) {
        _advance();
        result = SubtractNode(result, _term());
      }
    }

    return result;
  }

  // Builds a subtree for MULTIPLY and DIVIDE Ops which generally require two factors, say a and b.
  Node _term() {
    var result = _factor();

    while (_currentToken != null && [TokenType.Multiply, TokenType.Divide].contains(_currentToken.type)) {
      if (_currentToken.type == TokenType.Multiply) {
        _advance();
        result = MultiplyNode(result, _factor());
      } else if (_currentToken.type == TokenType.Divide) {
        _advance();
        result = DivideNode(result, _factor());
      }
    }

    return result;
  }

  // Builds subtree that is either a [NumberNode], [PlusNode] or [MinusNode].
  // That is, it works with numbers.
  Node _factor() {
    final token = _currentToken;

    if (token.type == TokenType.OpenBracket) {
      _advance();

      final result = _expression();

      if (_currentToken.type != TokenType.CloseBracket) {
        throw Exception('Expected a closing bracket');
      }

      _advance();

      return result;
    } else if (token.type == TokenType.Number) {
      _advance();

      return NumberNode(token.value);
    } else if (token.type == TokenType.Plus) {
      _advance();

      return PlusNode(_factor());
    } else if (token.type == TokenType.Minus) {
      _advance();

      return MinusNode(_factor());
    }

    throw Exception('Syntax error');
  }
}
