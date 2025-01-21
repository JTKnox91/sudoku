import 'package:flutter/material.dart';
import 'package:sudoku/core/autoscale_text.dart';
import 'package:sudoku/core/value.dart';
import 'package:sudoku/models/cell.dart';

class CandidatesWidget extends StatelessWidget {
  static final textStyle = TextStyle(
    fontWeight: FontWeight.w600,  // Semi-bold
    color: Colors.grey[700],      // Dark grey
  );

  final Cell cell;

  const CandidatesWidget({
    super.key,
    required this.cell,
  });

  String _valueOrEmpty(Value value) {
    return cell.candidates.contains(value) ? value.toString() : '';
  }

  @override
  Widget build(BuildContext context) {
    final candidatesArray = <Iterable<String>>[
      [
        _valueOrEmpty(Value.one),
        _valueOrEmpty(Value.two),
        _valueOrEmpty(Value.three),
      ],[
        _valueOrEmpty(Value.four),
        _valueOrEmpty(Value.five),
        _valueOrEmpty(Value.six),
      ],[
        _valueOrEmpty(Value.seven),
        _valueOrEmpty(Value.eight),
        _valueOrEmpty(Value.nine),
      ],
    ];

    return Column(
      children: candidatesArray.map((row) => 
        Expanded(
          child: Row( 
            children: row.map((text) => 
              Expanded(
                child: Center(
                  child: AutoScaleText(
                    text, 0.75,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ).toList()
          )
        )
      ).toList(),
    );
  }
} 