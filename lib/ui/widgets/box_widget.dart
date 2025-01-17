import 'package:flutter/material.dart';
import 'package:sudoku/ui/widgets/cell_widget.dart';

class BoxWidget extends StatelessWidget {
  final int boxNumber;

  const BoxWidget({
    super.key,
    required this.boxNumber,
  }) : assert(boxNumber >= 1 && boxNumber <= 9);

  @override
  Widget build(BuildContext context) {
    final boxRow = ((boxNumber - 1) ~/ 3) * 3 + 1;
    final boxCol = ((boxNumber - 1) % 3) * 3 + 1;
    final backgroundColor = boxNumber % 2 == 0
        ? Colors.white
        : Colors.grey.shade200; 

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: Column(
        children: List.generate(3, (rowOffset) {
          return Expanded(
            child: Row(
              children: List.generate(3, (colOffset) {
                final row = boxRow + rowOffset;
                final col = boxCol + colOffset;
                return Expanded(
                  child: CellWidget(
                    row: row,
                    col: col,
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
} 