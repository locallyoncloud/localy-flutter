import 'dart:ui';

class AppColors {
  static const PRIMARY_COLOR = Color(0xFF455A64);

  static const WHITE = Color(0xFFFFFFFF);
  static const BG_WHITE = Color(0xFFF7F6FB);
  static const GREY = Color(0xFF303030);
  static const RED = Color(0xFFEF5350);
  static const GREEN = Color(0xFF4CAF50);
  static const BLUE = Color(0xFF2196F3);


  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}