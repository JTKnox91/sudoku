import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/widgets/box_widget.dart';

class BoardWidget extends StatefulWidget {
  final Board board;

  const BoardWidget({
    super.key,
    required this.board,
  });

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  final FocusNode _focusNode = FocusNode();

  void onFocusChange(bool hasFocus) {
    if (!hasFocus) {
      widget.board.selectCell(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Board>(
      create: (context) => widget.board,
      // child: BoardProvider(
      //   board: widget.board,
        child: Focus(
          focusNode: _focusNode,
          onFocusChange: onFocusChange,
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
        ),
      // ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
} 