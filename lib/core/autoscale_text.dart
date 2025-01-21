import 'package:flutter/material.dart';

class AutoScaleText extends StatelessWidget {
  final String text;
  final double heightRatio;
  final TextStyle? style;
  final TextAlign? textAlign;

  const AutoScaleText(
    this.text,
    this.heightRatio, {
    super.key,
    this.style,
    this.textAlign,
  }) : assert(heightRatio > 0 && heightRatio <= 1, 'Height ratio must be between 0 and 1');

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.maxHeight.isFinite, 'AutoScaleText max height must be finite');
        final fontSize = constraints.maxHeight * heightRatio;
        
        return Text(
          text,
          style: (style ?? const TextStyle()).copyWith(
            fontSize: fontSize,
          ),
          textAlign: textAlign,
        );
      },
    );
  }
}