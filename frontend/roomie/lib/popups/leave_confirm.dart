import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

/// Shows a warning popup. Returns true if the user confirms.
Future<bool> showLeaveDialog(
  BuildContext context, {
  required String title,
  required String message,
  String leavelabel = 'Leave',
  String cancelLabel = 'Cancel',
  IconData icon = Icons.warning_amber_rounded,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierColor: RColors.scrim,
    builder: (ctx) => Dialog(
      backgroundColor: RColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: RColors.warningLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: RColors.warning, size: 28),
            ),
            const SizedBox(height: 16),
            Text(title, style: RFonts.h4, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(
              message,
              style: RFonts.bodyRegular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      side: const BorderSide(color: RColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      cancelLabel,
                      style: RFonts.emphasis(color: RColors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx, true),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(46),
                      backgroundColor: RColors.error,
                      foregroundColor: RColors.buttonText,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(leavelabel, style: RFonts.button),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  return result ?? false;
}