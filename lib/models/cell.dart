import 'package:sudoku/core/value.dart';
import 'dart:collection';

class Cell {
  Value? _value;
  final Set<Value> _candidates = Set.from(Value.values);

  Value? get value => _value;

  Set<Value> get candidates => UnmodifiableSetView(_candidates);

  Cell();

  void setValue(Value newValue) {
    _value = newValue;
    _candidates.clear();
  }

  bool removeCandidate(Value number) {
    return _candidates.remove(number);
  }
} 