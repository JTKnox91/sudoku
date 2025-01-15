import 'package:flutter/material.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/ui/widgets/board_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Solver & Visualizer'),
      ),
      body: Center(
        child: BoardWidget(
          board: Board(),
        ),
      ),
    );
  }
} 