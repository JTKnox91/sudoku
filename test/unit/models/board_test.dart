import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/models/cell.dart';
import 'package:sudoku/core/cell_name.dart';

void main() {
  group('Board', () {
    late Board board;

    setUp(() {
      board = Board();
    });

    test('initializes with 81 empty cells', () {
      expect(board.cells.length, equals(81));
      expect(board.cells.values.every((cell) => cell.value == null), isTrue);
    });

    test('cells are keyed by CellName', () {
      for (int row = 1; row <= 9; row++) {
        for (int col = 1; col <= 9; col++) {
          expect(board.cells[CellName(row, col)], isNotNull);
        }
      }
    });

    test('cells are keyed by row before column', () {
      // TODO: Implement this test after implementing view layer
    });

    test('cells map is unmodifiable', () {
      expect(
        () => board.cells[CellName(1, 1)] = Cell(),
        throwsUnsupportedError,
      );
    });

    test('can select and unselect cells', () {
      board.selectCell(CellName(1, 1));
      expect(board.selectedCell, equals(board.cells[CellName(1, 1)]));
      
      board.selectCell(null);
      expect(board.selectedCell, isNull);
    });
  });
} 