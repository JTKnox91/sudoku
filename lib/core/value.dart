import 'package:flutter/services.dart';

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
    if (!isValidInt(number)) {
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

  /// Return the corresponding Value enum for a valid sodoku integer.
  static Value fromChar(String char) {
    if (isValidChar(char)) {
      return fromInt(int.parse(char));
    } else {
      throw ArgumentError('Invalid single digit char: $char');
    }
  }

   static Value fromKey(LogicalKeyboardKey key) {
    if (isValidKey(key)) {
      return _validKeys[key]!;
    } else {
      throw ArgumentError('Invalid logical key: $key');
    }
  }

  /// Check if the number is a valid Sudoku value.
  static bool isValidInt(int number) {
    return number >= 1 && number <= 9;
  }

  /// Check if the number is a valid Sudoku value.
  static bool isValidChar(String char) {
    return RegExp(r'^[1-9]$').hasMatch(char);
  }

  static final _validKeys = <LogicalKeyboardKey, Value>{
    LogicalKeyboardKey.digit1: Value.one  ,
    LogicalKeyboardKey.digit2: Value.two,
    LogicalKeyboardKey.digit3: Value.three,
    LogicalKeyboardKey.digit4: Value.four,
    LogicalKeyboardKey.digit5: Value.five,
    LogicalKeyboardKey.digit6: Value.six,
    LogicalKeyboardKey.digit7: Value.seven,
    LogicalKeyboardKey.digit8: Value.eight,
    LogicalKeyboardKey.digit9: Value.nine,
  };

  static bool isValidKey(LogicalKeyboardKey key) {
    return _validKeys.containsKey(key);
  }

  @override
  String toString() => number.toString();
} 