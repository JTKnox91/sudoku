import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/has_cells.dart';
import 'package:sudoku/core/value.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/models/cell.dart';

abstract class Group with ChangeNotifier, HasCells {
  final Map<CellName, Cell> _cells = {};
  final Map<Value, int> _candidates = {
    for (final value in Value.values) value: 0,
  };
  
  @override
  UnmodifiableMapView<CellName, Cell> get cells => UnmodifiableMapView(_cells);

  UnmodifiableMapView<Value, int> get candidates => UnmodifiableMapView(_candidates);

  @protected
  Iterable<CellName> generateCellNames();

  Group(Board board) {
    for (final cellName in generateCellNames()) {
      final cell = board[cellName];
      cell.addListener(refreshCandidates);
      _cells[cellName] = cell;
    }
    refreshCandidates();
  }

  void refreshCandidates() {
    bool hasChanged = false;
    _candidates.updateAll((valueCandidate, oldCount) {
      int newCount = 0;
      for (final cell in cells.values) {
        if (cell.candidates.contains(valueCandidate)) {
          newCount++;
        }
      }
      if (newCount != oldCount) { hasChanged = true; }
      return newCount;
    });
    if (hasChanged) {
      notifyListeners();
    }
  }
}

class Row extends Group {
  final int rowNum;

  Row(super.board, this.rowNum);

  @override
  bool isCellNameInRange(CellName cellName) => cellName.row == rowNum;

  @override
  Iterable<CellName> generateCellNames() {
    return Iterable.generate(Board.size, (colDelta) => CellName(rowNum, 1 + colDelta));
  }
}

class Column extends Group {
  final int colNum;

  Column(super.board, this.colNum);

  @override
  bool isCellNameInRange(CellName cellName) => cellName.col == colNum;

  @override
  Iterable<CellName> generateCellNames() {
    return Iterable.generate(Board.size, (rowDelta) => CellName(1 + rowDelta, colNum));
  }
}

class Box extends Group {
  final int boxNum;

  CellName get _topLeftInBox{
    return CellName((boxNum - 1) ~/ 3 * 3 + 1, (boxNum - 1) % 3 * 3 + 1);
  }

  Box(super.board, this.boxNum);

  @override
  bool isCellNameInRange(CellName cellName) {
    return
      cellName.row >= _topLeftInBox.row && cellName.row <= _topLeftInBox.row + 2 &&
      cellName.col >= _topLeftInBox.col && cellName.col <= _topLeftInBox.col + 2;
  }

  @override
  Iterable<CellName> generateCellNames() {
    return [
      ...Iterable.generate(3, (colDelta) => CellName(_topLeftInBox.row, _topLeftInBox.col + colDelta)),
      ...Iterable.generate(3, (colDelta) => CellName(_topLeftInBox.row+1, _topLeftInBox.col + colDelta)),
      ...Iterable.generate(3, (colDelta) => CellName(_topLeftInBox.row+2, _topLeftInBox.col + colDelta)),
    ];
    
  }
}
