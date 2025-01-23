import 'package:flutter/material.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/widgets/board_widget.dart';
import 'package:sudoku/core/constants.dart';
import 'package:sudoku/solvers/solver_v0.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final board = Board();
    Future.delayed(Duration.zero).then((_) {
      SolverV0(board).init();
    });
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Layout.gridUnit * 2),
          child: BoardWidget(
            board: board,
          ),
        ),
      )
    );
  }
} 