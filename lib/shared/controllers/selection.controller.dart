import 'package:flutter/material.dart';

class SelectionController<T> extends ValueNotifier<List<T>> {
  SelectionController(super.initial);

  bool isSelected(T value) => this.value.contains(value);

  void toggle(T value, {bool single = false}) {
    if (single) {
      this.value = [value];
    } else {
      if (isSelected(value)) {
        this.value = [...this.value]..remove(value);
      } else {
        this.value = [...this.value, value];
      }
    }
  }
}
