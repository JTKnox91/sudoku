import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sudoku/core/autoscale_text.dart';

void main() {
  group('AutoScaleText', () {
    testWidgets('scales text based on container height and ratio', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center( // Need Center or else SizeBox will expand to fit parent.
            child: SizedBox(
              height: 100,
              width: 100,
              child: AutoScaleText('test_text', 0.5,),
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('test_text'));
      expect(textWidget.style?.fontSize, 50.0); // 100 * 0.5
    });

    testWidgets('preserves other text style properties', (tester) async {
      const textStyle = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Center( // Need Center or else SizeBox will expand to fit parent.
            child: SizedBox(
              height: 100,
              width: 100,
              child: AutoScaleText('test_text', 0.5,
                style: textStyle,
              ),
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('test_text'));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.red);
      expect(textWidget.style?.fontSize, 50.0);
    });

    testWidgets('applies text alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Center( // Need Center or else SizeBox will expand to fit parent.
            child: SizedBox(
              height: 100,
              width: 100,
              child: AutoScaleText('test_text', 0.5,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('test_text'));
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('throws assertion error for invalid height ratio', (tester) async {
      expect(
        () => AutoScaleText('Test', 1.5), 
        throwsAssertionError, // Cannot be great than 100%
      );

      expect(
        () => AutoScaleText( 'Test', 0),
        throwsAssertionError, // Cannot <= 0%
      );
    });
  });
} 