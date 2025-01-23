import 'package:sudoku/core/constants.dart';

class CellName implements Comparable<CellName> {
  static bool isValidInt(int rowOrColumn) {
    return rowOrColumn >= 1 && rowOrColumn <= maximumGroupSize; 
  }

  final int row;  
  final int col;

  CellName(this.row, this.col) {
    if (!isValidInt(row) || !isValidInt(col)) {
      throw ArgumentError('Row and column must be between 1 and 9');
    }
  }

  @override
  String toString() => 'r$row,c$col';

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is CellName &&
    row == other.row &&
    col == other.col;

  @override
  int get hashCode => Object.hash(row, col);

  @override
  int compareTo(CellName other) {
    return _sortingIndex(this) - _sortingIndex(other);
  }

  bool operator >(CellName other) => compareTo(other) > 0;
  bool operator <(CellName other) => compareTo(other) < 0;
  bool operator >=(CellName other) => compareTo(other) >= 0;
  bool operator <=(CellName other) => compareTo(other) <= 0;

  static int _sortingIndex(CellName name) => (name.row -1) * maximumGroupSize + (name.col -1);
}