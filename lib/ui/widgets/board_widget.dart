import 'package:flutter/material.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/widgets/cell_widget.dart';

class BoardWidget extends StatelessWidget {
  final Board board;

  const BoardWidget({
    super.key,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(Board.size, (row) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(Board.size, (col) {
              return CellWidget(cell: board.cells[cellName(row+1, col+1)]!);
            }),
          );
        }),
      ),
    );
  }
} 