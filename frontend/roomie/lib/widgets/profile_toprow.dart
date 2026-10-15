import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';
import 'vibe_status.dart';

class ProfileTopRow extends StatelessWidget {
  final Vibe vibe;
  final ValueChanged<Vibe> onVibeChanged;

  const ProfileTopRow({
    super.key,
    required this.vibe,
    required this.onVibeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 20, color: RColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        const Spacer(),
        VibePill(vibe: vibe),
        const SizedBox(width: 4),
        PopupMenuButton<Vibe>(
          tooltip: 'Change vibe',
          icon: const Icon(Icons.edit_outlined, color: RColors.primary),
          color: RColors.surface,
          elevation: 4,
          shadowColor: RColors.shadow,
          offset: const Offset(0, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: RColors.divider),
          ),
          onSelected: onVibeChanged,
          itemBuilder: (_) => Vibe.values.map((v) {
            final isSelected = v == vibe;
            return PopupMenuItem<Vibe>(
              value: v,
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration:
                        BoxDecoration(color: v.color, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      v.label,
                      style: RFonts.body(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? v.textColor : RColors.textPrimary,
                      ),
                    ),
                  ),
                  if (isSelected) Icon(Icons.check, size: 18, color: v.color),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}