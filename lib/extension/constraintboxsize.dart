import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

extension Constraintboxsize on BoxConstraints {
  BoxConstraints constrainstSize() {
    return const BoxConstraints(
      maxWidth: 1200,
    );
  }
}
