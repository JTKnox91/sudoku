import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/models/group.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/value.dart';

class GroupTest {
  final int rowOrColOrBoxNum;
  final Iterable<CellName> expectedGenerated;
  final Iterable<CellName> expectedValid;
  final Iterable<CellName> expectedInvalid;

  GroupTest(this.rowOrColOrBoxNum, {
    required this.expectedGenerated,
    required this.expectedValid,
    required this.expectedInvalid,
  });
}

void main() {
  late Board board;

  setUp(() {
    board = Board();
  });

  group(Row, () {
    final testCases = <GroupTest>[
      GroupTest(1,
        expectedGenerated: [
          CellName(1, 1), CellName(1, 2), CellName(1, 3),
          CellName(1, 4), CellName(1, 5), CellName(1, 6),
          CellName(1, 7), CellName(1, 8), CellName(1, 9),
        ],
        expectedValid: [CellName(1, 1), CellName(1, 5), CellName(1, 9)],
        expectedInvalid: [CellName(2, 1), CellName(3, 5), CellName(9, 9)],
      ),
      GroupTest(5,  
        expectedGenerated: [
          CellName(5, 1), CellName(5, 2), CellName(5, 3),
          CellName(5, 4), CellName(5, 5), CellName(5, 6),
          CellName(5, 7), CellName(5, 8), CellName(5, 9),
        ],
        expectedValid: [CellName(5, 1), CellName(5, 5), CellName(5, 9)],
        expectedInvalid: [CellName(1, 5), CellName(4, 5), CellName(9, 5)],
      ),
      GroupTest(9,
        expectedGenerated: [
          CellName(9, 1), CellName(9, 2), CellName(9, 3),
          CellName(9, 4), CellName(9, 5), CellName(9, 6),
          CellName(9, 7), CellName(9, 8), CellName(9, 9),
        ],
        expectedValid: [CellName(9, 1), CellName(9, 5), CellName(9, 9)],
        expectedInvalid: [CellName(1, 9), CellName(5, 9), CellName(8, 9)],
      ),
    ];

    for (final testCase in testCases) {
      test('(${testCase.rowOrColOrBoxNum}) generates correct cell names', () {
        final row = board.rows[testCase.rowOrColOrBoxNum]!;
        final cellNames = row.generateCellNames().toList();

        expect(cellNames.length, equals(testCase.expectedGenerated.length));
        expect(cellNames, equals(testCase.expectedGenerated));
      });

      test('(${testCase.rowOrColOrBoxNum}) correctly validates cell names', () {
        final row = board.rows[testCase.rowOrColOrBoxNum]!;

        for (final validCellName in testCase.expectedValid) {
          expect(row.isCellNameInRange(validCellName), isTrue,
            reason: '$validCellName should be in range for Row'
          );
        }

        for (final invalidCellName in testCase.expectedInvalid) {
          expect(row.isCellNameInRange(invalidCellName), isFalse,
            reason: '$invalidCellName should not be in range for Row'
          );
        }
      });
    }
  });

  group(Column, () {
    final testCases = <GroupTest>[
      GroupTest(1,
        expectedGenerated: [
          CellName(1, 1), CellName(2, 1), CellName(3, 1),
          CellName(4, 1), CellName(5, 1), CellName(6, 1),
          CellName(7, 1), CellName(8, 1), CellName(9, 1),
        ],
        expectedValid: [CellName(1, 1), CellName(5, 1), CellName(9, 1)],
        expectedInvalid: [CellName(1, 2), CellName(1, 5), CellName(1, 9)],
      ),
      GroupTest(5,
        expectedGenerated: [
          CellName(1, 5), CellName(2, 5), CellName(3, 5),
          CellName(4, 5), CellName(5, 5), CellName(6, 5),
          CellName(7, 5), CellName(8, 5), CellName(9, 5),
        ],
        expectedValid: [CellName(1, 5), CellName(5, 5), CellName(9, 5)],
        expectedInvalid: [CellName(5, 1), CellName(5, 4), CellName(5, 9)],
      ),
      GroupTest(9,
        expectedGenerated: [
          CellName(1, 9), CellName(2, 9), CellName(3, 9),
          CellName(4, 9), CellName(5, 9), CellName(6, 9),
          CellName(7, 9), CellName(8, 9), CellName(9, 9),
        ],
        expectedValid: [CellName(1, 9), CellName(5, 9), CellName(9, 9)],
        expectedInvalid: [CellName(9, 1), CellName(9, 5), CellName(9, 8)],
      ),
    ];

    for (final testCase in testCases) {
      test('(${testCase.rowOrColOrBoxNum}) generates correct cell names', () {
        final col = board.cols[testCase.rowOrColOrBoxNum]!;
        final cellNames = col.generateCellNames().toList();

        expect(cellNames.length, equals(testCase.expectedGenerated.length));
        expect(cellNames, equals(testCase.expectedGenerated));
      });

      test('(${testCase.rowOrColOrBoxNum}) correctly validates cell names', () {
        final col = board.cols[testCase.rowOrColOrBoxNum]!;

        for (final validCellName in testCase.expectedValid) {
          expect(col.isCellNameInRange(validCellName), isTrue,
            reason: '$validCellName should be in range for Column'
          );
        }

        for (final invalidCellName in testCase.expectedInvalid) {
          expect(col.isCellNameInRange(invalidCellName), isFalse,
            reason: '$invalidCellName should not be in range for Column'
          );
        }
      });
    }
  });

  group(Box, () {
    final testCases = <GroupTest>[
      GroupTest(3,
        expectedGenerated: [
          CellName(1, 7), CellName(1, 8), CellName(1, 9),
          CellName(2, 7), CellName(2, 8), CellName(2, 9),
          CellName(3, 7), CellName(3, 8), CellName(3, 9),
        ],
        expectedValid: [CellName(1, 7), CellName(2, 8), CellName(3, 9)],
        expectedInvalid: [CellName(1, 1), CellName(4, 7), CellName(7, 7)],
      ),
      GroupTest(5,
        expectedGenerated: [
          CellName(4, 4), CellName(4, 5), CellName(4, 6),
          CellName(5, 4), CellName(5, 5), CellName(5, 6),
          CellName(6, 4), CellName(6, 5), CellName(6, 6),
        ],
        expectedValid: [CellName(4, 4), CellName(5, 5), CellName(6, 6)],
        expectedInvalid: [CellName(1, 4), CellName(4, 1), CellName(7, 7)],
      ),
      GroupTest(7,
        expectedGenerated: [
          CellName(7, 1), CellName(7, 2), CellName(7, 3),
          CellName(8, 1), CellName(8, 2), CellName(8, 3),
          CellName(9, 1), CellName(9, 2), CellName(9, 3),
        ],
        expectedValid: [CellName(7, 1), CellName(8, 2), CellName(9, 3)],
        expectedInvalid: [CellName(1, 1), CellName(7, 4), CellName(7, 7)],
      ),
    ];

    for (final testCase in testCases) {
      test('(${testCase.rowOrColOrBoxNum}) generates correct cell names', () {
        final box = board.boxes[testCase.rowOrColOrBoxNum]!;
        final cellNames = box.generateCellNames().toList();

        expect(cellNames.length, equals(testCase.expectedGenerated.length));
        expect(cellNames, equals(testCase.expectedGenerated));
      });

      test('(${testCase.rowOrColOrBoxNum}) correctly validates cell names', () {
        final box = board.boxes[testCase.rowOrColOrBoxNum]!;

        for (final validCellName in testCase.expectedValid) {
          expect(box.isCellNameInRange(validCellName), isTrue,
            reason: '$validCellName should be in range for Box'
          );
        }

        for (final invalidCellName in testCase.expectedInvalid) {
          expect(box.isCellNameInRange(invalidCellName), isFalse,
            reason: '$invalidCellName should not be in range for Box'
          );
        }
      });
    }
  });

  group(Group, () {
    test('tracks candidates correctly', () {
      final row = board.rows[1]!;
      
      // Initially all cells should have all candidates
      for (final count in row.candidates.values) {
        expect(count, equals(9),
            reason: 'confirm starting with all 9 candidates for each value');
      }

      // Set a value in one of the cells
      board[CellName(1, 1)].removeCandidate(Value.five);

      // Should now have one less candidate for all values in that cell
      for (final entry in row.candidates.entries) {
        if (entry.key == Value.five) {
          expect(entry.value, equals(8),
            reason: 'should update count after a child removes a candidate');
        } else {
          expect(entry.value, equals(9),
              reason: 'confirm other counts are unchanged');
        }
      }
    });

    test('#refreshCandidates notifies only when candidates change', () {
      // Group is abstract. Using Column arbitraily, but it should work for any subclass.
      final group = board.cols[1]!;
      
      var notificationCount = 0;
      group.addListener(() {
        notificationCount++;
      });

      // First refresh shouldn't notify since nothing changed
      group.refreshCandidates();
      expect(notificationCount, 0, reason: 'should not notify initially');

      // Notification should be triggered when a cell's candidates change
      final firstCell = group.cells.values.first;
      firstCell.removeCandidate(Value.one);
      expect(notificationCount, 1, reason: 'should notify when a cell\'s candidates change');

      // Notification should be triggered when a cell's value changes
      final lastCell = group.cells.values.last;
      lastCell.setValue(Value.one);
      expect(notificationCount, 2, reason: 'should notify when a cell\'s value changes');
      
      // This refresh should notify since candidates changed
      group.refreshCandidates();
      expect(notificationCount, 2,
        reason: 'should not nessecarily notify on every refresh');

      // Another notification triggered by a cell without changes
      firstCell.notifyListeners();
      expect(notificationCount, 2,
        reason: 'should not nessecarily propogate every child notification');
    });
  });
} 