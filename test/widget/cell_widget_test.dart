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
  final CellName expectedName;

  TestCase(this.row, this.col) : expectedName = CellName(row, col);
}

class CellWidgetTest extends StatelessWidget {
  static const double cellSize = 50;

  final List<List<CellWidget>> cellWidgetsGrid;
  final Board board;

  CellWidgetTest(this.cellWidgetsGrid, {
    super.key,
    Board? board,
  }) : board = board ?? Board(),
    assert(cellWidgetsGrid.isNotEmpty && cellWidgetsGrid[0].isNotEmpty,
        'Cell Widgets must be non-empty');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: SizedBox(
          height: cellSize * cellWidgetsGrid.length,
          width: cellSize * cellWidgetsGrid[0].length,
          child: BoardProvider(
            board: board,
            child: Column(
              children: cellWidgetsGrid.map((cellWidgetsRow) {
                return Expanded(
                  child: Row(
                    children: cellWidgetsRow.map((cellWidget) {
                      return Expanded(child: cellWidget);
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  group('CellWidget', () {
    testWidgets('uses correct cell name based on row/col', (tester) async {
      final testCases = <TestCase>[
        TestCase(1, 1),  // First cell
        TestCase(9, 9),  // Last cell
        TestCase(4, 6),  // Something in the middle
      ];

      for (final testCase in testCases) {
        await tester.pumpWidget(CellWidgetTest([
          [CellWidget(row: testCase.row, col: testCase.col)]
        ]));

        final cell = tester.widget<CellWidget>(find.byType(CellWidget));
        expect(cell.name, equals(testCase.expectedName));
      }
    });

    testWidgets('renders cell value correctly', (tester) async {
      final board = Board();
      const expectedValue = Value.five;

      final cellWidgetWithValue = CellWidget(row: 1, col: 1);
      board.cells[cellWidgetWithValue.name]!.setValue(expectedValue);
      // To be realistic, choosing a cell that would not be affected by sudoku rules.
      final cellWidgetWithoutValue = CellWidget(row: 4, col: 4);

      await tester.pumpWidget(CellWidgetTest([
        [cellWidgetWithValue, cellWidgetWithoutValue]
      ], board: board));

      // Confirm underlying model state is correct before checking view layer.
      assert(board.cells[cellWidgetWithValue.name]!.candidates.isEmpty, 
          'Cell With Value should have no candidates');
      assert(board.cells[cellWidgetWithoutValue.name]!.candidates.length == 9,
          'Cell Without Value should have all candidates');

      // Check cell with value '5' and no other numbers (no vandidates visible)
      expect(
        find.descendant(
          of: find.byWidget(cellWidgetWithValue),
          matching: find.text(expectedValue.toString())
        ),
        findsOneWidget
      );
      
      // Check cell with candidates has all numbers 1-9 exactly one (no additional text visible)
      final foundCellWidgetWithoutValue = find.byWidget(cellWidgetWithoutValue);
      for (final value in Value.values) {
        expect(
          find.descendant(
            of: foundCellWidgetWithoutValue,
            matching: find.text(value.toString())
          ),
          findsOneWidget,
          reason: 'Should find candidate ${value.toString()} in empty cell'
        );
      }
    });
  });
} 