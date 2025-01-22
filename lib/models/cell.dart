import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:sudoku/core/value.dart';


class Cell with ChangeNotifier {
  Value? _value;
  final Set<Value> _candidates = Set.from(Value.values);

  Value? get value => _value;

  Set<Value> get candidates => UnmodifiableSetView(_candidates);

  Cell();

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