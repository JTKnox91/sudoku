import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sudoku Solver & Visualizer'),
      ),
      body: const Center(
        child: Text('Sudoku board will go here'),
      ),
    );
  }
} 