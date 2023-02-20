import 'package:flutter/material.dart';

extension EmptyPadding on num {
  // This is a shortcut for sizedbox but it's not actually efficient since you will lose the const constructor I only used it for learning purposes.
  SizedBox get sbh => SizedBox(height: toDouble());

  SizedBox get sbw => SizedBox(width: toDouble());
}
