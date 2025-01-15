import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sudoku/core/value.dart';
import 'package:sudoku/models/cell.dart';

class CellWidget extends StatelessWidget {
  static const double size = 40.0;

  final Cell cell;

  const CellWidget({
    super.key,
    required this.cell,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: Text(
          // TODO: Remove after testing layout
          Value.fromInt(Random().nextInt(9)+1).toString(),
          // cell.value?.toString() ?? '',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
} 