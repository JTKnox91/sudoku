String cellName(int row, int col) {
  if (row <= 0 || row > 9 || col <= 0 || col > 9) {
    throw ArgumentError('Row and column must be between 1 and 9');
  }
  return '$row,$col';
} 