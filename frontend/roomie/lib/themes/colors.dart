import 'package:flutter/material.dart';

class RColors {
  // ── Brand / Primary ──────────────────────────────────────
  static const Color primary = Color(0xFF3D2B9E);
  static const Color primaryLight = Color(0xFFEDE8FF);
  static const Color primaryMid = Color(0xFF7B6BAA);
  static const Color primarySoft = Color(0xFF5A4A9B);
  static const Color primaryDark = Color(0xFF2E2078); // pressed/active states
  static const Color primaryContainer = Color(0xFFDCD3FF); // chips, selected bg

  // ── Neutrals / Surfaces ───────────────────────────────────
  static const Color bg = Color(0xFFF7F5FF);
  static const Color surface = Color(0xFFFFFFFF); // cards, sheets, dialogs
  static const Color surfaceAlt = Color(0xFFFBFAFF); // subtle alt row/section bg
  static const Color divider = Color(0xFFE4DFF7);
  static const Color border = Color(0xFFC4BAF0);

  // ── Text hierarchy ────────────────────────────────────────
  static const Color text = Color(0x80000000); // secondary (existing)
  static const Color textPrimary = Color(0xFF1A1625); // headings, body, near-black w/ purple warmth
  static const Color textTertiary = Color(0x4D000000); // captions, meta info
  static const Color textDisabled = Color(0x33000000);
  static const Color hint = Color(0xFFB0A3D8);
  static const Color orText = Color(0xFF9E8FCC);
  static const Color buttonText = Color(0xFFF0EDFF);
  static const Color logoText = Color(0xFFE8E4FF);
  static const Color link = Color(0xFF5A4A9B); // same family as primarySoft, distinguishable as tappable

  // ── Status: Error ─────────────────────────────
  static const Color error = Color(0xFFE24B4A);
  static const Color errorLight = Color(0xFFFBE7E7); // error banners/badges bg
  static const Color errorText = Color(0xFFA32D2D);

  // ── Status: Success ───────────────────────────────────────
  static const Color success = Color(0xFF3DA35E);
  static const Color successLight = Color(0xFFE3F5E8);
  static const Color successText = Color(0xFF276B3E);

  // ── Status: Warning ───────────────────────────────────────
  static const Color warning = Color(0xFFE0A83D);
  static const Color warningLight = Color(0xFFFBF0DC);
  static const Color warningText = Color(0xFF8A5F13);

  // ── Status: Info ──────────────────────────────────────────
  static const Color info = Color(0xFF3D7BE0);
  static const Color infoLight = Color(0xFFE3EDFB);
  static const Color infoText = Color(0xFF1F4E8C);

  // ── Nav bar ───────────────────────────────────────────────
  static const Color navBarContainer = Color(0x14000000);
  static const Color navBarIconUnselected = Color(0x80000000);
  static const Color navBarIconSelected = primary;

  // ── Inputs ────────────────────────────────────────────────
  static const Color inputBackground = Color(0xFFEDE8FF);
  static const Color inputBorder = Color(0xFFC4BAF0);
  static const Color inputBorderFocused = primary;
  static const Color inputBorderError = error;
  static const Color inputPlaceholder = Color(0xFFB0A3D8);
  static const Color inputDisabledBackground = Color(0xFFF0EEF8);

  // ── Disabled (buttons, controls) ─────────────────────────
  static const Color disabledBackground = Color(0xFFE3DEF5);
  static const Color disabledText = Color(0xFFADA3CC);

  // ── Elevation / Overlay ───────────────────────────────────
  static const Color shadow = Color(0x1F3D2B9E); // purple-tinted, cohesive with palette
  static const Color scrim = Color(0x99000000); // modal/bottom-sheet backdrop
  static const Color shimmer = Color(0xFFEDE8FF); // skeleton loading base
  static const Color shimmerHighlight = Color(0xFFF7F5FF);

// ── Vibe Status Colors ─────────────────────────────────

// Available — Green
static const Color vibeAvailable = Color(0xFF3DA35E);
static const Color vibeAvailableLight = Color(0xFFE3F5E8);
static const Color vibeAvailableText = Color(0xFF276B3E);

// Busy — Amber
static const Color vibeBusy = Color(0xFFE0A83D);
static const Color vibeBusyLight = Color(0xFFFBF0DC);
static const Color vibeBusyText = Color(0xFF8A5F13);

// Taking Exam — Blue
static const Color vibeTakingExam = Color(0xFF3D7BE0);
static const Color vibeTakingExamLight = Color(0xFFE3EDFB);
static const Color vibeTakingExamText = Color(0xFF1F4E8C);

// Sick — Red
static const Color vibeSick = Color(0xFFE24B4A);
static const Color vibeSickLight = Color(0xFFFBE7E7);
static const Color vibeSickText = Color(0xFFA32D2D);

// On Vacation — Teal
static const Color vibeOnVacation = Color(0xFF0D9488);
static const Color vibeOnVacationLight = Color(0xFFCCFBF1);
static const Color vibeOnVacationText = Color(0xFF115E59);
}