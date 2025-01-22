import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/value.dart';

void main() {
  group(Value, () {
    test('#toString returns number as string', () {
      expect(Value.one.toString(), equals('1'));
      expect(Value.five.toString(), equals('5'));
      expect(Value.nine.toString(), equals('9'));
    });

    group('#isValidInt', () {
      test('accepts valid ints', () {
        for (int i = 1; i <= 9; i++) {
          expect(Value.isValidInt(i), isTrue);
        }
      });

      test('rejects invalid ints', () {
        expect(Value.isValidInt(0), isFalse);
        expect(Value.isValidInt(10), isFalse);
        expect(Value.isValidInt(-1), isFalse);
      });
    });

    group('#fromInt', () {
      test('constructs Value enums from valid ints', () {
        expect(Value.fromInt(1), equals(Value.one));
        expect(Value.fromInt(5), equals(Value.five));
        expect(Value.fromInt(9), equals(Value.nine));
      });

      test('throws ArgumentError for invalid ints', () {
        expect(() => Value.fromInt(0), throwsArgumentError);
        expect(() => Value.fromInt(10), throwsArgumentError);
        expect(() => Value.fromInt(-1), throwsArgumentError);
      });
    });

    group('#isValidChar', () {
      test('accepts valid chars', () {
        for (String c in ['1', '2', '3', '4', '5', '6', '7', '8', '9']) {
          expect(Value.isValidChar(c), isTrue);
        }
      });

      test('rejects invalid chars', () {
        expect(Value.isValidChar('0'), isFalse);
        expect(Value.isValidChar('a'), isFalse);
        expect(Value.isValidChar('10'), isFalse);
        expect(Value.isValidChar(''), isFalse);
        expect(Value.isValidChar('8.0'), isFalse);
        expect(Value.isValidChar('-1'), isFalse);
      });
    });

    group('#fromChar', () {
      test('constructs Value enums from valid chars', () {
        expect(Value.fromChar('1'), equals(Value.one));
        expect(Value.fromChar('5'), equals(Value.five));
        expect(Value.fromChar('9'), equals(Value.nine));
      });

      test('throws ArgumentError for invalid chars', () {
        expect(() => Value.fromChar('0'), throwsArgumentError);
        expect(() => Value.fromChar('a'), throwsArgumentError);
        expect(() => Value.fromChar('10'), throwsArgumentError);
        expect(() => Value.fromChar(''), throwsArgumentError);
        expect(() => Value.fromChar('8.0'), throwsArgumentError);
        expect(() => Value.fromChar('-1'), throwsArgumentError);
      });
    });

    group('#isValidKey', () {
      test('accepts valid keys', () {
        final validKeys = [
          LogicalKeyboardKey.digit1,
          LogicalKeyboardKey.digit2,
          LogicalKeyboardKey.digit3,
          LogicalKeyboardKey.digit4,
          LogicalKeyboardKey.digit5,
          LogicalKeyboardKey.digit6,
          LogicalKeyboardKey.digit7,
          LogicalKeyboardKey.digit8,
          LogicalKeyboardKey.digit9,
        ];
        
        for (var key in validKeys) {
          expect(Value.isValidKey(key), isTrue);
        }
      });

      test('rejects invalid keys', () {
        expect(Value.isValidKey(LogicalKeyboardKey.digit0), isFalse);
        expect(Value.isValidKey(LogicalKeyboardKey.keyA), isFalse);
        expect(Value.isValidKey(LogicalKeyboardKey.space), isFalse);
        expect(Value.isValidKey(LogicalKeyboardKey.arrowUp), isFalse);
        expect(Value.isValidKey(LogicalKeyboardKey.arrowDown), isFalse);
        expect(Value.isValidKey(LogicalKeyboardKey.arrowLeft), isFalse);
        expect(Value.isValidKey(LogicalKeyboardKey.arrowRight), isFalse);
      });
    });

    group('#fromKey', () {
      test('constructs Value enums from valid keys', () {
        expect(Value.fromKey(LogicalKeyboardKey.digit1), equals(Value.one));
        expect(Value.fromKey(LogicalKeyboardKey.digit5), equals(Value.five));
        expect(Value.fromKey(LogicalKeyboardKey.digit9), equals(Value.nine));
      });

      test('throws ArgumentError for invalid keys', () {
        expect(() => Value.fromKey(LogicalKeyboardKey.digit0), throwsArgumentError);
        expect(() => Value.fromKey(LogicalKeyboardKey.keyA), throwsArgumentError);
        expect(() => Value.fromKey(LogicalKeyboardKey.space), throwsArgumentError);
        expect(() => Value.fromKey(LogicalKeyboardKey.arrowUp), throwsArgumentError);
      });
    });
  });
} 