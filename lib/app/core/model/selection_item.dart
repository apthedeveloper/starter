import 'package:flutter/material.dart';

class AppSelectionItem<V, D> {
  final V id;
  final D data;
  final IconData? icon;

  const AppSelectionItem({required this.id, required this.data, this.icon});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AppSelectionItem && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
