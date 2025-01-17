import 'package:flutter/material.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/widgets/box_widget.dart';
import 'package:sudoku/ui/providers/board_provider.dart';

class BoardWidget extends StatelessWidget {
  final Board board;

  const BoardWidget({
    super.key,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return BoardProvider(
      board: board,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
          ),
          child: Column(
            children: List.generate(3, (boxRow) {
              return Expanded(
                child: Row(
                  children: List.generate(3, (boxCol) {
                    final boxNumber = boxRow * 3 + boxCol + 1;
                    return Expanded(
                      child: BoxWidget(boxNumber: boxNumber),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
} 