import 'package:flutter/material.dart';

class SelectableItem<V, D> {
  final V id;
  final D data;
  final IconData? icon;

  const SelectableItem({required this.id, required this.data, this.icon});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SelectableItem && other.id == id);
  } 

  @override
  int get hashCode => id.hashCode;
}
