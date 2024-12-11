import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// This extension adds a method that restricts the maximum width of a widget to 1200.
extension Constraintboxsize on BoxConstraints {
  // Restricts the maximum width of the constraints to 1200.
  BoxConstraints constrainstSize() {
    return const BoxConstraints(
      maxWidth: 1200,
    );
  }
}
