enum Value {
  one(1),
  two(2),
  three(3),
  four(4),
  five(5),
  six(6),
  seven(7),
  eight(8),
  nine(9);

  final int number;
  const Value(this.number);

  /// Return the corresponding Value enum for a valid sodoku integer.
  static Value fromInt(int number) {
    if (!isValid(number)) {
      throw ArgumentError('Invalid Sudoku value: $number');
    }
    return <int, Value>{
      1: Value.one,
      2: Value.two,
      3: Value.three,
      4: Value.four,
      5: Value.five,
      6: Value.six,
      7: Value.seven,
      8: Value.eight,
      9: Value.nine,
    }[number]!;
  }

  /// Check if the number is a valid Sudoku value.
  static bool isValid(int number) {
    return number >= 1 && number <= 9;
  }

  @override
  String toString() => number.toString();
} 