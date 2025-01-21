import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/has_cells.dart';
import 'package:sudoku/models/cell.dart';
import 'dart:collection';

class Board implements HasCells {
  static const int size = 9;

  final Map<CellName, Cell> _cells = {};
  
  @override
  UnmodifiableMapView<CellName, Cell> get cells => UnmodifiableMapView(_cells);
  
  Cell? _selectedCell;
  Cell? get selectedCell => _selectedCell;
  
  Board() {
    for (int row = 1; row <= Board.size; row++) {
      for (int col = 1; col <= Board.size; col++) {
        _cells[CellName(row, col)] = Cell();
      }
    }
  }

  void selectCell(CellName? cellName) {
    if (cellName == null) {
      _selectedCell = null;
    } else {
      _selectedCell = cells[cellName]!;
    }
  }
} 