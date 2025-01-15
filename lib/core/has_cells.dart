import 'package:sudoku/models/cell.dart';

/// Interface for classes that contain cells
abstract interface class HasCells {
  /// Returns a read-only view of the cells
  Map<String, Cell> get cells;
}
