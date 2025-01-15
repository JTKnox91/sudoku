import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/cell_name.dart';

void main() {
  group('cellName', () {
    test('returns correct string for valid coordinates', () {
      expect(cellName(0, 0), equals('0,0'));
      expect(cellName(4, 5), equals('4,5'));
      expect(cellName(8, 8), equals('8,8'));
    });

    test('throws ArgumentError for invalid coordinates', () {
      expect(() => cellName(-1, 5), throwsArgumentError);
      expect(() => cellName(5, 10), throwsArgumentError);
    });
  });
} 