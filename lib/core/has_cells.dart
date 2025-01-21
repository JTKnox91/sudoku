import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/models/cell.dart';

/// Interface for classes that contain cells
abstract interface class HasCells {
  /// Returns a read-only view of the cells
  Map<CellName, Cell> get cells;
}
