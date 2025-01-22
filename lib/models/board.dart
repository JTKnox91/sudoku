import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/has_cells.dart';
import 'package:sudoku/models/cell.dart';

class Board with ChangeNotifier implements HasCells {
  static const int size = 9;

  final Map<CellName, Cell> _cells = {};
  
  @override
  UnmodifiableMapView<CellName, Cell> get cells => UnmodifiableMapView(_cells);
  
  CellName? _selectedCellName;
  Cell? get selectedCell => _selectedCellName == null ? null : _cells[_selectedCellName]!;
  
  Board() {
    for (int row = 1; row <= Board.size; row++) {
      for (int col = 1; col <= Board.size; col++) {
        final cell = Cell();
        cell.addListener(notifyListeners);
        _cells[CellName(row, col)] = cell;
      }
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