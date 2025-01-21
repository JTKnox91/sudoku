import 'package:flutter/material.dart';
import 'package:sudoku/core/autoscale_text.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/ui/providers/board_provider.dart';
import 'package:sudoku/ui/widgets/candidates_widget.dart';


class CellWidget extends StatelessWidget {
  static const textStyle = TextStyle(
    fontWeight: FontWeight.w600,  // Semi-bold
  );

  final CellName name;

  CellWidget({
    super.key,
    required int row,
    required int col,
  }) : name = CellName(row, col);
  
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
      child: cell.value == null ? 
        CandidatesWidget(cell: cell) :
        Center(
          child: AutoScaleText(cell.value!.toString(), 0.75,
            style: textStyle,
          ),
        ),
    );
  }
} 
