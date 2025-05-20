import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF3B49A1);           // لون العلامة (الأزرار، العناوين)
  static const Color primaryDark = Color(0xFF2E3C87);       // Hover أو درجات داكنة من primary
  static const Color background = Color(0xFFF4F6FB);         // خلفية صفحات
  static const Color white = Color(0xFFFFFFFF);              // أبيض للنصوص والخلفيات
  static const Color blackText = Color(0xFF1E2A38);          // نص أساسي
  static const Color greyText = Color(0xFF6D7D8B);           // نص وصفي
  static const Color lightGrey = Color(0xFFC7D1E0);          // حدود textfield
  static const Color hintText = Color(0xFF9DAAB9);           // Placeholder
  static const Color subtitle = Color(0xFFA1AFC0);           // أسماء ثانوية أو تفاصيل
  static const Color error = Color(0xFFD32F2F);              // لون الخطأ
  static const Color shadow = Color(0x33D0D9E6);             // ظل خفيف (20% شفافية)
  static const Color black = Colors.black;             // ظل خفيف (20% شفافية)
}
