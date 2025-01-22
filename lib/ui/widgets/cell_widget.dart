import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/core/autoscale_text.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/models/board.dart';
import 'package:sudoku/models/cell.dart';
import 'package:sudoku/ui/widgets/candidates_widget.dart';


class CellWidget extends StatefulWidget {
  static final firstCellName = CellName(1,1);

  static String _semanticLabel(CellName name, Cell cell) {
    if (cell.value != null) {
      return 'Cell $name; Value: ${cell.value}';
    } else {
      return 'Cell $name; Candidates: ${cell.candidates}';
    }
  }

  static const textStyle = TextStyle(
    fontWeight: FontWeight.w600,  // Semi-bold
  );

  final CellName name;

  CellWidget({
    super.key,
    required int row,
    required int col,
  }) : name = CellName(row, col);

  @override
  State<CellWidget> createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final board = Provider.of<Board>(context);
    final cell = board.cells[widget.name]!;
    final isSelected = board.selectedCell == cell;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Focus(
        focusNode: _focusNode,
        canRequestFocus: true,
        // Allow tabbing into cells, but use arrow keys to navigate around
        skipTraversal: widget.name == CellWidget.firstCellName ? false : true,
        onFocusChange: (hasFocus) {
          if (hasFocus) { board.selectCell(widget.name); }
        },
        child: Semantics(
          label: CellWidget._semanticLabel(widget.name, cell),
          readOnly: false,
          child: ExcludeSemantics(
            child: Container(
              decoration: BoxDecoration(
                border: isSelected ? Border.all(
                  color: Colors.blue.withOpacity(0.8),
                  width: 4.0,
                ) : Border.all(
                  color: Colors.black,
                  width: 1.0,
                )
              ),
              child: cell.value == null ? 
                CandidatesWidget(cell: cell) :
                Center(
                  child: AutoScaleText(cell.value!.toString(), 0.75,
                    style: CellWidget.textStyle,
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
} 
