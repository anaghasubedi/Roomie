import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'by continuing you agree to our terms & privacy policy',
      textAlign: TextAlign.center,
      style: RFonts.body(fontSize: 10, color: RColors.primaryMid),
    );
  }
}