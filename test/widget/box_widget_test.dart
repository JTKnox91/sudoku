import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/providers/board_provider.dart';
import 'package:sudoku/ui/widgets/box_widget.dart';
import 'package:sudoku/ui/widgets/cell_widget.dart';

class TestCase {
  final int boxNumber;
  final int cellPosition;
  final CellName expectedName;

  TestCase(this.boxNumber, this.cellPosition, this.expectedName);
}

void main() {
  group('BoxWidget', () {
    testWidgets('passes correct row/col to CellWidgets', (tester) async {
      final testCases = [
        // Box 1, Cells 1, 5, 9
        TestCase(1, 1, CellName(1, 1)),
        TestCase(1, 5, CellName(2, 2)),
        TestCase(1, 9, CellName(3, 3)),
        // Box 9, Cells 1, 5, 9
        TestCase(9, 1, CellName(7, 7)),
        TestCase(9, 5, CellName(8, 8)),
        TestCase(9, 9, CellName(9, 9)),
        // Box 5, Cells 3, 5, 7
        TestCase(5, 3, CellName(4, 6)),
        TestCase(5, 5, CellName(5, 5)),
        TestCase(5, 7, CellName(6, 4)),
      ];

      for (final testCase in testCases) {
        await tester.pumpWidget(MaterialApp(
          home: BoardProvider(
            board: Board(),
            child: BoxWidget(boxNumber: testCase.boxNumber),
          ),
        ));

        final cellWidget = find.byWidgetPredicate((widget) {
          if (widget is! CellWidget) return false;
          return widget.name == testCase.expectedName;
        });

        expect(cellWidget, findsOneWidget,
            reason: 'Box ${testCase.boxNumber}, Cell ${testCase.cellPosition} should have name ${testCase.expectedName}');
      }
    });

    testWidgets('renders correct background colors', (tester) async {
      for (int i = 1; i <= 9; i++) {
        await tester.pumpWidget(MaterialApp(
          home: BoardProvider(
            board: Board(),
            child: BoxWidget(boxNumber: i),
          ),
        ));

        final container = find.byType(Container).first;
        final BoxDecoration decoration = tester.widget<Container>(container).decoration as BoxDecoration;
        
        if (i % 2 == 1) {
          expect(decoration.color, equals(BoxWidget.offsetColor));
        } else {
          expect(decoration.color, equals(BoxWidget.baseColor));
        }
      }
    });
  });
} 