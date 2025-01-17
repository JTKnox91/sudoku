import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/value.dart';

void main() {
  group('Value', () {
    group('fromInt', () {
      test('converts valid integers to corresponding Value enums', () {
        expect(Value.fromInt(1), equals(Value.one));
        expect(Value.fromInt(2), equals(Value.two));
        expect(Value.fromInt(3), equals(Value.three));
        expect(Value.fromInt(4), equals(Value.four));
        expect(Value.fromInt(5), equals(Value.five));
        expect(Value.fromInt(6), equals(Value.six));
        expect(Value.fromInt(7), equals(Value.seven));
        expect(Value.fromInt(8), equals(Value.eight));
        expect(Value.fromInt(9), equals(Value.nine));
      });

      test('throws ArgumentError for invalid integers', () {
        expect(() => Value.fromInt(0), throwsArgumentError);
        expect(() => Value.fromInt(10), throwsArgumentError);
        expect(() => Value.fromInt(-1), throwsArgumentError);
      });
    });

    group('isValid', () {
      test('returns true for integers 1-9', () {
        for (var i = 1; i <= 9; i++) {
          expect(Value.isValid(i), isTrue, reason: '$i should be valid');
        }
      });

      test('returns false for integers outside 1-9 range', () {
        final invalidNumbers = [-1, 0, 10, 100];
        for (var num in invalidNumbers) {
          expect(Value.isValid(num), isFalse, reason: '$num should be invalid');
        }
      });
    });
  });
} 