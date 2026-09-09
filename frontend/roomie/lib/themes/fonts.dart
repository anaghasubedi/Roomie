import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';


class RFonts {
  // ── Base font getters ─────────────────────────────────────
  static TextStyle heading({
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w600,
    Color color = RColors.textPrimary,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.plusJakartaSans(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle body({
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w400,
    Color color = RColors.text,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  static TextStyle emphasis({
    double fontSize = 15,
    FontWeight fontWeight = FontWeight.w600,
    Color color = RColors.buttonText,
    double? height,
    double? letterSpacing,
  }) =>
      GoogleFonts.manrope(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      );

  // ── Headings ──────────────────────────────────────────────
  static TextStyle h1 = heading(fontSize: 32, fontWeight: FontWeight.w700, height: 1.2);
  static TextStyle h2 = heading(fontSize: 26, fontWeight: FontWeight.w700, height: 1.25);
  static TextStyle h3 = heading(fontSize: 22, fontWeight: FontWeight.w600, height: 1.3);
  static TextStyle h4 = heading(fontSize: 18, fontWeight: FontWeight.w600, height: 1.3);

  // ── Body ──────────────────────────────────────────────────
  static TextStyle bodyLarge = body(fontSize: 16, height: 1.5);
  static TextStyle bodyRegular = body(fontSize: 15, height: 1.5);
  static TextStyle bodySmall = body(fontSize: 13, height: 1.4, color: RColors.textTertiary);

  // ── Labels / meta ────────────────────────────────────────
  static TextStyle label = body(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: RColors.textPrimary,
    letterSpacing: 0.1,
  );
  static TextStyle hintText = body(fontSize: 14, color: RColors.hint);
  static TextStyle caption = body(fontSize: 12, color: RColors.textTertiary);

  // ── Emphasis / interactive ──────────────────────────────
  static TextStyle button = emphasis(fontSize: 15, letterSpacing: 0.2);
  static TextStyle buttonSmall = emphasis(fontSize: 13);
  static TextStyle badge = emphasis(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.3);
  static TextStyle link = emphasis(fontSize: 14, fontWeight: FontWeight.w600, color: RColors.link);

  // ── Status text (pairs with RColors status colors) ───────
  static TextStyle error = body(fontSize: 13, fontWeight: FontWeight.w500, color: RColors.errorText);
  static TextStyle success = body(fontSize: 13, fontWeight: FontWeight.w500, color: RColors.successText);
  static TextStyle warning = body(fontSize: 13, fontWeight: FontWeight.w500, color: RColors.warningText);

  /// Wire this into MaterialApp(theme: ThemeData(textTheme: RFonts.textTheme))
  static TextTheme get textTheme => TextTheme(
        displayLarge: h1,
        displayMedium: h2,
        headlineSmall: h3,
        titleLarge: h4,
        bodyLarge: bodyLarge,
        bodyMedium: bodyRegular,
        bodySmall: bodySmall,
        labelLarge: button,
        labelMedium: label,
        labelSmall: caption,
      );
}