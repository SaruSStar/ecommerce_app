import 'package:flutter/Material.dart';

extension HexToColor on dynamic {
  Color toColor() {
    return Color(
        int.parse(this.toLowerCase().substring(1, 7), radix: 16) + 0xFF000000);
  }
}
