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
        _cells[CellName(row, col)] = Cell();
      }
    }
  }

  void selectCell(CellName? cellName) {
    if (_selectedCellName == cellName) return;
    if (cellName == null) {
      _selectedCellName = null;
    } else {
      _selectedCellName = cellName;
    }
    notifyListeners();
  }
}
