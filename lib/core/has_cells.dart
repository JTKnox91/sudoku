import 'package:flutter/foundation.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/models/cell.dart';

/// Interface for classes that contain cells
mixin HasCells {
  bool isCellNameInRange(CellName cellName);
  /// Returns a read-only view of the cells
  @protected
  Map<CellName, Cell> get cells;

  Cell operator [](CellName cellName) {
    if (!isCellNameInRange(cellName)) {
      throw RangeError('$cellName is not in this $runtimeType');
    }
    return cells[cellName]!;
  }
}
