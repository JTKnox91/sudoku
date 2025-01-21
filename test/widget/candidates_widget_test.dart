import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/value.dart';
import 'package:sudoku/models/cell.dart';
import 'package:sudoku/ui/widgets/candidates_widget.dart';

void main() {
  group('CandidatesWidget', () {
    late Cell cell;
    late Widget testWidget;

    setUp(() {
      cell = Cell();
      testWidget = MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 100,
            height: 100,
            child: CandidatesWidget(cell: cell),
          ),
        ),
      );
    });

    Future<void> pumpCandidatesWidget(WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
    }

    testWidgets('can display all candidates', (tester) async {
      // Do not modify cell. It starts with all candidates intially.

      await pumpCandidatesWidget(tester);

      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
      expect(find.text('9'), findsOneWidget);
    });

    testWidgets('displays only specified candidates', (tester) async {
      cell.removeCandidate(Value.one);
      cell.removeCandidate(Value.five);
      cell.removeCandidate(Value.nine);

      await pumpCandidatesWidget(tester);

      // Should not texts for the removed candidates
      expect(find.text('1'), findsNothing);
      expect(find.text('5'), findsNothing);
      expect(find.text('9'), findsNothing);

      // Should still find the other candidates
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('8'), findsOneWidget);
    });

    testWidgets('displays empty grid when no candidates', (tester) async {
      cell.setValue(Value.one);

      await pumpCandidatesWidget(tester);
      
      // Should not find any numbers
      for (var i = 1; i <= 9; i++) {
        expect(find.text('$i'), findsNothing);
      }
    });
  });
}