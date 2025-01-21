import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/cell_name.dart';

void main() {
  group('CellName', () {

    test('throws ArgumentError for invalid coordinates', () {
      expect(() => CellName(0, 0), throwsArgumentError);
      expect(() => CellName(-1, 5), throwsArgumentError);
      expect(() => CellName(5, 10), throwsArgumentError);
    });

    test('is identical to equivalent names', () {
      expect(CellName(1, 1), CellName(1, 1));
    });

  });
} 