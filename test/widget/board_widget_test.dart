import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/widgets/board_widget.dart';
import 'package:sudoku/ui/widgets/box_widget.dart';
import 'package:flutter/services.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/value.dart';

class TestValueKey {
  final CellName name;
  final Value value;
  final LogicalKeyboardKey key;

  TestValueKey(this.name, this.value, this.key);
}

class TestArrowKey {
  final CellName origin;
  final CellName destination;
  final LogicalKeyboardKey key;

  TestArrowKey(this.origin, this.destination, this.key);
}

void main() {
  group(BoardWidget, () {
    testWidgets('provides Board to children', (tester) async {
      final board = Board();
      await tester.pumpWidget(MaterialApp(
        home: BoardWidget(board: board),
      ));

      final context = tester.element(find.byType(BoxWidget).first);
      expect(Provider.of<Board>(context, listen: false), equals(board));
    });

    testWidgets('numbers BoxWidgets 1-9', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: BoardWidget(board: Board()),
      ));

      for (int i = 1; i <= 9; i++) {
        expect(find.byWidgetPredicate(
          (widget) => widget is BoxWidget && widget.boxNumber == i,
        ), findsOneWidget);
      }
    });

    group('(keyboard input)', () {
      testWidgets('sets the cell value onnumber keys 1-9', (tester) async {
        final board = Board();
        await tester.pumpWidget(MaterialApp(home: BoardWidget(board: board)));
        
        final valueKeyTests = <TestValueKey>[
          TestValueKey(CellName(1, 1), Value.one, LogicalKeyboardKey.digit1),
          TestValueKey(CellName(2, 2), Value.two, LogicalKeyboardKey.digit2),
          TestValueKey(CellName(3, 3), Value.three, LogicalKeyboardKey.digit3),
          TestValueKey(CellName(4, 4), Value.four, LogicalKeyboardKey.digit4),
          TestValueKey(CellName(5, 5), Value.five, LogicalKeyboardKey.digit5),
          TestValueKey(CellName(6, 6), Value.six, LogicalKeyboardKey.digit6),
          TestValueKey(CellName(7, 7), Value.seven, LogicalKeyboardKey.digit7),
          TestValueKey(CellName(8, 8), Value.eight, LogicalKeyboardKey.digit8),
          TestValueKey(CellName(9, 9), Value.nine, LogicalKeyboardKey.digit9),
        ];
        
        for (final test in valueKeyTests) {
          board.selectCell(test.name);
          await tester.pump();
          await tester.sendKeyEvent(test.key);
          await tester.pump();

          expect(board.cells[test.name]!.value, equals(test.value));
        }
      });

      testWidgets('moves the selected cell on arrow keys', (tester) async {
        final board = Board();
        await tester.pumpWidget(MaterialApp(home: BoardWidget(board: board)));

        final arrowKeyTests = <TestArrowKey>[
          TestArrowKey(CellName(5, 5), CellName(4, 5), LogicalKeyboardKey.arrowUp),
          TestArrowKey(CellName(5, 5), CellName(6, 5), LogicalKeyboardKey.arrowDown),
          TestArrowKey(CellName(5, 5), CellName(5, 4), LogicalKeyboardKey.arrowLeft),
          TestArrowKey(CellName(5, 5), CellName(5, 6), LogicalKeyboardKey.arrowRight),
          // Edge cases
          TestArrowKey(CellName(1, 1), CellName(1, 1), LogicalKeyboardKey.arrowUp),
          TestArrowKey(CellName(9, 9), CellName(9, 9), LogicalKeyboardKey.arrowDown),
          TestArrowKey(CellName(1, 1), CellName(1, 1), LogicalKeyboardKey.arrowLeft),
          TestArrowKey(CellName(9, 9), CellName(9, 9), LogicalKeyboardKey.arrowRight),
        ];

        for (final test in arrowKeyTests) {
          // Select starting cell
          board.selectCell(test.origin);
          await tester.pump();

          // Send arrow key event
          await tester.sendKeyEvent(test.key);
          await tester.pump();

          // Verify the selected cell moved as expected
          expect(board.selectedCell, equals(board.cells[test.destination]));
        }
      });

      testWidgets('does not for other numbers, letters, or special keys', (tester) async {
        final board = Board();
        await tester.pumpWidget(MaterialApp(home: BoardWidget(board: board)));
        
        // Select a cell to test with
        final testCell = CellName(1, 1);
        board.selectCell(testCell);
        await tester.pump();

        // Test various non-valid keys
        final invalidKeys = [
          LogicalKeyboardKey.digit0,
          LogicalKeyboardKey.keyA,
          LogicalKeyboardKey.keyZ,
          LogicalKeyboardKey.enter,
          LogicalKeyboardKey.space,
        ];

        for (final key in invalidKeys) {
          await tester.sendKeyEvent(key);
          await tester.pump();

          // Verify the cell value remains null
          expect(board.cells[testCell]!.value, isNull);
        }
      });

      testWidgets('does nothing when no cell is selected', (tester) async {
        final board = Board();
        await tester.pumpWidget(MaterialApp(home: BoardWidget(board: board)));
        
        // No cell selected
        await tester.sendKeyEvent(LogicalKeyboardKey.digit5);
        await tester.pump();

        // Verify no cells were modified
        expect(board.cells.values.every((cell) => cell.value == null), isTrue,
          reason: 'No cell should have been modified'
        );

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
        await tester.pump();

        expect(board.selectedCell, isNull, reason: 'No cell should have been moed to');
      });
    });
  });
} 