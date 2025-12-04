import 'package:flutter/material.dart';

/// Centralized text styles with scalable and theme-aware behavior.
abstract class AppStyles {
  /// Base builder for all text styles.
  static TextStyle _base({required double size, required FontWeight weight, Color? color}) {
    return TextStyle(fontSize: size, fontWeight: weight, color: color);
  }

  //-------- Weights --------//

  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  //-------- Generic --------//

  static TextStyle mediumStyle(double size, {Color? color}) =>
      _base(size: size, weight: medium, color: color);

  static TextStyle semiBoldStyle(double size, {Color? color}) =>
      _base(size: size, weight: semiBold, color: color);

  static TextStyle boldStyle(double size, {Color? color}) =>
      _base(size: size, weight: bold, color: color);

  static TextStyle extraBoldStyle(double size, {Color? color}) =>
      _base(size: size, weight: extraBold, color: color);
}
