import 'package:sudoku/core/value.dart';
import 'dart:collection';

class Cell {
  Value? value;
  final Set<Value> _candidates = Set.from(Value.values);

  UnmodifiableSetView<Value> get candidates => UnmodifiableSetView(_candidates);

  Cell();

  void setValue(Value newValue) {
    value = newValue;
    _candidates.clear();
  }

  bool removeCandidate(Value number) {
    return _candidates.remove(number);
  }
} 