enum TokenType {
  Number,
  Plus,
  Minus,
  Multiply,
  Divide,
  OpenBracket,
  CloseBracket,
}

/// A [Token] represents the type of every character in the input.
class Token {
  final TokenType type;

  /// A number token may have [`value`] but will be `null` for other token types.
  final double value;

  Token(this.type, {this.value});

  @override
  String toString() {
    return "$type${value != null ? ':+${value}' : ''}";
  }
}
