import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class FieldError extends StatelessWidget {
  final String message;
  const FieldError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        message,
        style: RFonts.body(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: RColors.error,
        ),
      ),
    );
  }
}