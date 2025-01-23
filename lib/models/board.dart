import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/constants.dart';
import 'package:sudoku/core/has_cells.dart';
import 'package:sudoku/models/cell.dart';
import 'package:sudoku/models/group.dart';
class Board with ChangeNotifier, HasCells {
  static const int size = maximumGroupSize;

  final Map<CellName, Cell> _cells = {};
  final Map<int, Row> _rows = {};
  final Map<int, Column> _cols = {};
  final Map<int, Box> _boxes = {};
  
  @override
  UnmodifiableMapView<CellName, Cell> get cells => UnmodifiableMapView(_cells);
  
  @override
  bool isCellNameInRange(CellName cellName) => true;
  
  CellName? _selectedCellName;
  Cell? get selectedCell => _selectedCellName == null ? null : _cells[_selectedCellName]!;

  UnmodifiableMapView<int, Row> get rows => UnmodifiableMapView(_rows);
  UnmodifiableMapView<int, Column> get cols => UnmodifiableMapView(_cols);
  UnmodifiableMapView<int, Box> get boxes => UnmodifiableMapView(_boxes);
  
  Board() {
    for (int row = 1; row <= Board.size; row++) {
      for (int col = 1; col <= Board.size; col++) {
        final cell = Cell();
        cell.addListener(notifyListeners);
        _cells[CellName(row, col)] = cell;
      }
    }

    for (int groupNum = 1; groupNum <= Board.size; groupNum++) {
      _rows[groupNum] = Row(this, groupNum);
      _cols[groupNum] = Column(this, groupNum);
      _boxes[groupNum] = Box(this, groupNum);
    }
  }

  void selectCell(CellName? cellName) {
    if (_selectedCellName == cellName) return;
    _selectedCellName = cellName;
    notifyListeners();
  }

  void _move(int rowDelta, int colDelta) {
    if (_selectedCellName == null) return;
    final newRow = _selectedCellName!.row + rowDelta;
    final newCol = _selectedCellName!.col + colDelta;
    if (!CellName.isValidInt(newRow) ||
        !CellName.isValidInt(newCol)) {
      return;
    }
    selectCell(CellName(newRow, newCol));
  }

  void moveUp() {
    _move(-1, 0);
  }

  void moveDown() {
    _move(1, 0);
  }

  void moveLeft() {
    _move(0, -1);
  }

  void moveRight() {
    _move(0, 1);
  }
}