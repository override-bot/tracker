import 'package:flutter/material.dart';

class OptimalText {
  optimizeText(size, context) {
    return size / 720 * MediaQuery.of(context).size.height;
  }
}
