import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: RColors.border, thickness: 0.5),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'or continue with',
            style: RFonts.body(fontSize: 11, color: RColors.orText),
          ),
        ),
        const Expanded(
          child: Divider(color: RColors.border, thickness: 0.5),
        ),
      ],
    );
  }
}