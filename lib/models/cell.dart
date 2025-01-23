import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:sudoku/core/cell_name.dart';
import 'package:sudoku/core/value.dart';
import 'package:sudoku/models/group.dart';

class Cell with ChangeNotifier {
  final CellName name;

  Value? _value;
  final Set<Value> _candidates = Set.from(Value.values);

  Value? get value => _value;
  Set<Value> get candidates => UnmodifiableSetView(_candidates);
  late Group parentRow;
  late Group parentCol;
  late Group parentBox;

  Cell(this.name);

  void setValue(Value newValue) {
    _value = newValue;
    _candidates.clear();
    notifyListeners();
  }

  bool removeCandidate(Value number) {
    if (_candidates.contains(number)) {
      _candidates.remove(number);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
} 