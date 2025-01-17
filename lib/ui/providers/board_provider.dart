import 'package:flutter/material.dart';
import 'package:sudoku/models/board.dart';

class BoardProvider extends InheritedWidget {
  final Board board;

  const BoardProvider({
    super.key,
    required this.board,
    required super.child,
  });

  static Board of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<BoardProvider>();
    assert(provider != null, 'No BoardProvider found in context');
    return provider!.board;
  }

  @override
  bool updateShouldNotify(BoardProvider oldWidget) {
    return board != oldWidget.board;
  }
} 