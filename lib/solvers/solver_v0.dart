import 'package:flutter/foundation.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/models/cell.dart';
import 'package:sudoku/models/group.dart';

class SolverV0 {
  final Board _board;
  bool _isSolving = false;

  final _changedCells = <Cell>{};
  final _checkParents = <Cell>{};

  SolverV0(this._board);

  void init() {
    for (final cell in _board.cells.values) {
      cell.addListener(() {
        _changedCells.add(cell);
        solve();
      });
    }
    _changedCells.addAll(_board.cells.values);
    _checkParents.addAll(_board.cells.values);
    solve();
  }

  void solve() {
    if (_isSolving) { 
      debugPrint('already solving');
      return;
    }
    _isSolving = true;

    if (_changedCells.isEmpty && _checkParents.isEmpty) {
      debugPrint('no changes to act on');
      _isSolving = false;
      return;
    }


    debugPrint('solving cells');
    while (_changedCells.isNotEmpty) {
      final cell = _changedCells.first;
       _changedCells.remove(cell);
      _solveCell(cell);
    }

    debugPrint('solving groups');
    while (_checkParents.isNotEmpty) {
      final child = _checkParents.first;
      _checkParents.remove(child);
      for (final group in [child.parentRow, child.parentCol, child.parentBox]) {
        _solveGroup(group);
      }
    }

    _isSolving = false;
    solve();
  }

  void _solveCell(Cell cell) {
    debugPrint('solving cell ${cell.name}, with value ${cell.value}');
    if (cell.value == null) {
      if (cell.candidates.length == 1) {
        debugPrint('cell has one candidate');
        cell.setValue(cell.candidates.single);
        debugPrint('cell value set to ${cell.value}');
        _checkParents.add(cell);
      }
    } else {
      for (final group in [cell.parentRow, cell.parentCol, cell.parentBox]) {
        for (final sibling in group.cells.values) {
          if (sibling.removeCandidate(cell.value!)) {
            _checkParents.add(sibling);
          }
        }
      }
    }
  }

  void _solveGroup(Group group) {
    if (group is Row) {
      debugPrint('checking row ${group.rowNum}');
    } else if (group is Column) {
      debugPrint('checking col ${group.colNum}');
    } else if (group is Box) {
      debugPrint('checking box ${group.boxNum}');
    }
    group.candidates.entries.where((entry) => entry.value == 1).forEach((entry) {
      debugPrint('found single ${entry.key}');
      bool found = false;
      for (final cell in group.cells.values) {
        if (cell.candidates.contains(entry.key)) {
          cell.setValue(entry.key);
          _checkParents.add(cell);
        } else if (cell.value == entry.key) {
          debugPrint('cell ${cell.name} already has value ${cell.value}');
        }
      }
      if (!found) {
        debugPrint('no cell found for ${entry.key}');
      }
    });
  }
}
