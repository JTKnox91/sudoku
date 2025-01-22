import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/models/cell.dart';
import 'package:sudoku/core/cell_name.dart';

void main() {
  group(Board, () {
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
      // TODO: Implement this test after implementing initializing with values.
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

    test('can move the selected cell', () {
      board.selectCell(CellName(1, 1));
      
      
      board.moveRight();
      board.moveRight();
      board.moveRight();
      board.moveDown();
      board.moveDown();
      board.moveDown();
      board.moveLeft();
      board.moveUp();
      // Net change of +2,+2, assuming every method worked
      expect(board.selectedCell, board.cells[CellName(3, 3)]);
    });

     test('does not move the selected cell out of bounds', () {
      board.selectCell(CellName(1, 9));
      
      board.moveUp();
      expect(board.selectedCell, board.cells[CellName(1, 9)]);
      
      board.moveRight();
      expect(board.selectedCell, board.cells[CellName(1, 9)]);

      board.selectCell(CellName(9, 1));

      board.moveDown();
      expect(board.selectedCell, board.cells[CellName(9, 1)]);

      board.moveLeft();
      expect(board.selectedCell, board.cells[CellName(9, 1)]);
    });

    group('(notifications)', () {
      late int notificationCount;

      setUp(() {
        notificationCount = 0;
        board.addListener(() => notificationCount++);
      });

      test('notifies listeners when cell is selected', () {
        board.selectCell(CellName(1, 1));
        expect(notificationCount, equals(1));
      });

      void selectAndResetNotifications([int row = 1, int col = 1]) {
        board.selectCell(CellName(row, col));
        notificationCount = 0;
      }

      test('notifies listeners when cell is unselected', () {
        selectAndResetNotifications();
        // Unselect cell
        board.selectCell(null);
        expect(notificationCount, equals(1));
      });

      test('notifies listeners when selecting a different cell', () {
        selectAndResetNotifications(1,1);
        // Select different cell
        board.selectCell(CellName(2, 2));
        expect(notificationCount, equals(1));
      });

      test('does not notify when selecting the same cell', () {
        selectAndResetNotifications(1,1);
        // Select same cell
        board.selectCell(CellName(1, 1));
        expect(notificationCount, equals(0));
      });

      test('notifies listeners when selection is moved', () {
        // Use cell not on the edge.
        selectAndResetNotifications(5,5);
        // Use each move method at least once.
        board.moveUp();
        board.moveDown();
        board.moveLeft();
        board.moveRight();
        expect(notificationCount, equals(4));
      });
    });
  });
} 