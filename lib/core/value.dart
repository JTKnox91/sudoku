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

  static Value? fromInt(int? number) {
    if (number == null) return null;
    return Value.values.firstWhere(
      (value) => value.number == number,
      orElse: () => throw ArgumentError('Invalid Sudoku value: $number'),
    );
  }

  @override
  String toString() => number.toString();
} 