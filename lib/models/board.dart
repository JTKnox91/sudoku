import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/has_cells.dart';
import 'package:sudoku/models/cell.dart';
import 'dart:collection';

class Board implements HasCells {
  static const int size = 9;

  final Map<String, Cell> _cells = {};
  
  @override
  UnmodifiableMapView<String, Cell> get cells => UnmodifiableMapView(_cells);
  
  Board() {
    for (int row = 1; row <= Board.size; row++) {
      for (int col = 1; col <= Board.size; col++) {
        _cells[cellName(row, col)] = Cell();
      }
    }
  }



} 