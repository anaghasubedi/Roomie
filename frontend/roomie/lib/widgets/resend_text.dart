import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class ResendText extends StatelessWidget {
  final bool canResend;
  final int countdown;
  final VoidCallback onResend;

  const ResendText({
    super.key,
    required this.canResend,
    required this.countdown,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canResend ? onResend : null,
      child: RichText(
        text: TextSpan(
          style: RFonts.body(
            fontSize: 13,
            color: RColors.primaryMid,
          ),
          children: [
            const TextSpan(text: "didn't get it? "),
            TextSpan(
              text: canResend ? 'resend code' : 'resend in ${countdown}s',
              style: RFonts.emphasis(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: canResend ? RColors.primary : RColors.primaryMid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}