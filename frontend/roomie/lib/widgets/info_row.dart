import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

/// Read-only label + value pair.
class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: RFonts.body(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: RColors.primarySoft,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: RFonts.body(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: RColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}