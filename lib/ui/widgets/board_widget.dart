import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/core/value.dart';
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
    if (!hasFocus) { widget.board.selectCell(null); }
  }

  KeyEventResult onKeyEvent(FocusNode _, KeyEvent event) {
    if (widget.board.selectedCell == null || 
        event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    final key = event.logicalKey;

    if (Value.isValidKey(key)) {
      final value = Value.fromKey(key);
      widget.board.selectedCell!.setValue(value);
    } else {
      switch (key) {
        case LogicalKeyboardKey.arrowUp:
          widget.board.moveUp();
          break;
        case LogicalKeyboardKey.arrowDown:
          widget.board.moveDown();
          break;
        case LogicalKeyboardKey.arrowLeft:
          widget.board.moveLeft();
          break;
        case LogicalKeyboardKey.arrowRight:
          widget.board.moveRight();
          break;
        default:
          return KeyEventResult.ignored;
      }
    }
    return KeyEventResult.handled; 
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Board>(
      create: (context) => widget.board,
      // child: BoardProvider(
      //   board: widget.board,
        child: Focus(
          focusNode: _focusNode,
          autofocus: true,
          onFocusChange: onFocusChange,
          onKeyEvent: onKeyEvent,
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
} 