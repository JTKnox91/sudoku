import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/value.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/providers/board_provider.dart';
import 'package:sudoku/ui/widgets/cell_widget.dart';

class TestCase {
  final int row;
  final int col;
  final String expectedName;

  TestCase(this.row, this.col, this.expectedName);
}

void main() {
  group('CellWidget', () {
    testWidgets('uses correct cell name based on row/col', (tester) async {
      final testCases = <TestCase>[
        TestCase(1, 1, cellName(1, 1)),  // First cell
        TestCase(9, 9, cellName(9, 9)),  // Last cell
        TestCase(4, 6, cellName(4, 6)),  // Something in the middle
      ];

      for (final testCase in testCases) {
        await tester.pumpWidget(MaterialApp(
          home: BoardProvider(
            board: Board(),
            child: CellWidget(row: testCase.row, col: testCase.col),
          ),
        ));

        final cell = tester.widget<CellWidget>(find.byType(CellWidget));
        expect(cell.name, equals(testCase.expectedName));
      }
    });

    testWidgets('renders cell value correctly', (tester) async {
      final board = Board();
      board.cells[cellName(1,1)]!.setValue(Value.five);
      // board.cells[cellName(4,4)] value is null by default

      await tester.pumpWidget(MaterialApp(
        home: BoardProvider(
          board: board,
          child: Column(
            children: [
              CellWidget(row: 1, col: 1),  // Should show "5"
              CellWidget(row: 4, col: 4),  // Should be empty
            ],
          ),
        ),
      ));

      expect(find.text('5'), findsOneWidget);
      expect(find.text(''), findsOneWidget);
    });
  });
} 