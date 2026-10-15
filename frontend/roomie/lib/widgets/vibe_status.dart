import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

enum Vibe {
  available('Available', RColors.vibeAvailable, RColors.vibeAvailableLight, RColors.vibeAvailableText,),
  busy('Busy', RColors.vibeBusy, RColors.vibeBusyLight, RColors.vibeBusyText),
  takingExam('Taking Exam', RColors.vibeTakingExam, RColors.vibeTakingExamLight, RColors.vibeTakingExamText),
  sick('Sick', RColors.vibeSick, RColors.vibeSickLight, RColors.vibeSickText),
  onVacation('On Vacation', RColors.vibeOnVacation, RColors.vibeOnVacationLight, RColors.vibeOnVacationText);

  final String label;
  final Color color; // dot / border
  final Color background;
  final Color textColor;

  const Vibe(this.label, this.color, this.background, this.textColor);
}

/// Read-only status display: colored dot + label.
class VibePill extends StatelessWidget {
  final Vibe vibe;
  const VibePill({super.key, required this.vibe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: vibe.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: vibe.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            vibe.label,
            style: RFonts.body(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: vibe.textColor,
            ),
          ),
        ],
      ),
    );
  }
}