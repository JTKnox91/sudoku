import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/core/autoscale_text.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/models/board.dart';
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
    final board = Provider.of<Board>(context);
    final cell = board.cells[name]!;
    final isSelected = board.selectedCell == cell;

    return GestureDetector(
      onTap: () => board.selectCell(name),
      child: Container(
        decoration: BoxDecoration(
            border: isSelected ? Border.all(
              color: Colors.blue.withOpacity(0.8),
            width: 4.0,
          ) : Border.all(
              color: Colors.black,
            width: 1.0,
          )
        ),
        child: cell.value == null ? 
          CandidatesWidget(cell: cell) :
          Center(
            child: AutoScaleText(cell.value!.toString(), 0.75,
              style: textStyle,
            ),
          ),
      ),
    );
  }
} 
