import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/value.dart';
import 'package:sudoku/models/cell.dart';

void main() {
  group('Cell', () {
    late Cell cell;

    setUp(() {
      cell = Cell();
    });

    test('initializes with all candidates and no value', () {
      expect(cell.value, isNull);
      expect(cell.candidates, equals(Set.from(Value.values)));
    });

    test('setValue clears candidates and sets value', () {
      cell.setValue(Value.five);
      
      expect(cell.value, equals(Value.five));
      expect(cell.candidates, isEmpty);
    });

    test('removeCandidate returns true when candidate exists', () {
      expect(cell.removeCandidate(Value.one), isTrue);
      expect(cell.candidates, isNot(contains(Value.one)));
    });

    test('removeCandidate returns false when candidate does not exist', () {
      cell.removeCandidate(Value.one);
      expect(cell.removeCandidate(Value.one), isFalse);
    });
  });
} 