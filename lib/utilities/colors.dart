import 'dart:ui';

class AppColors {
  static const PRIMARY_COLOR = Color(0xFF455A64);
  static const SECONDARY_COLOR = Color(0xFF9DC5BB);

  static const WHITE = Color(0xFFFFFFFF);
  static const BG_WHITE = Color(0xFFF7F6FB);
  static const GREY = Color(0xFF303030);
  static const RED = Color(0xFFEF5350);
  static const GREEN = Color(0xFF4CAF50);
  static const SUCCESS_GREEN = Color(0xFF2D6730);
  static const BLUE = Color(0xFF2196F3);
  static const ERROR = Color(0xFFB00020);
  static const ADMIN_GREY = Color(0xFF30333A);
  static const DISABLED_GREY = Color(0xffA5A5A5);
  static const POINT_COLOR = Color(0xffCDFF57);

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
  static String colorToHex(Color color) {
    String newColor= color.value.toRadixString(16);
    String hashTag = "#";
    newColor = hashTag + newColor.substring(2);
    return newColor;
  }
}