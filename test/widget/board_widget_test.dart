import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/widgets/board_widget.dart';
import 'package:sudoku/ui/widgets/box_widget.dart';

void main() {
  group('BoardWidget', () {
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
  });
} 