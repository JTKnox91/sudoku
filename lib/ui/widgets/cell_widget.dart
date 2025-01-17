import 'package:flutter/material.dart';
import 'package:sudoku/ui/providers/board_provider.dart';
import 'package:sudoku/core/cell_name.dart';

class CellWidget extends StatelessWidget {
  final String name;

  CellWidget({
    super.key,
    required int row,
    required int col,
  }) : name = cellName(row, col);

  @override
  Widget build(BuildContext context) {
    final board = BoardProvider.of(context);
    final cell = board.cells[name]!;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
          ),
        ),
      child: Center(
        child: Text(
          cell.value?.toString() ?? '',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
} 