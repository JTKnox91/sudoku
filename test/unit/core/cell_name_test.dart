import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/cell_name.dart';

void main() {
  group(CellName, () {

    test('throws ArgumentError for invalid coordinates', () {
      expect(() => CellName(0, 0), throwsArgumentError);
      expect(() => CellName(-1, 5), throwsArgumentError);
      expect(() => CellName(5, 10), throwsArgumentError);
    });

    group('(comparison)', () {

      test('treats equivalent names as equal', () {
        expect(CellName(1, 1), CellName(1, 1));
      });

      test('compares rows first', () {
        final cell1 = CellName(1, 9);
        final cell2 = CellName(3, 1);
        
        expect(cell1 < cell2, isTrue);
        expect(cell2 > cell1, isTrue);
        expect(cell1 <= cell2, isTrue);
        expect(cell2 >= cell1, isTrue);

        expect(cell1.compareTo(cell2), equals(-10));
        expect(cell2.compareTo(cell1), equals(10));
      });

      test('compares columns when rows are equal', () {
        final cell1 = CellName(2, 1);
        final cell2 = CellName(2, 3);
        
        expect(cell1 < cell2, isTrue);
        expect(cell2 > cell1, isTrue);
        expect(cell1 <= cell2, isTrue);
        expect(cell2 >= cell1, isTrue);

        expect(cell1.compareTo(cell2), equals(-2));
        expect(cell2.compareTo(cell1), equals(2));
      });

      test('handles equality correctly', () {
        final cell1 = CellName(5, 5);
        final cell2 = CellName(5, 5);
        
        expect(cell1 <= cell2, isTrue);
        expect(cell1 >= cell2, isTrue);
        expect(cell1 < cell2, isFalse);
        expect(cell1 > cell2, isFalse);

        expect(cell1.compareTo(cell2), equals(0));
        expect(cell2.compareTo(cell1), equals(0));
      });
    });
  });
} 