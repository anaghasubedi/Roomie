import 'package:flutter/material.dart';
import '../themes/avatar.dart'; // AnimalAvatar
import '../themes/colors.dart';
import '../themes/fonts.dart';

/// Popup dialog with a grid of animal avatars.
/// Returns the chosen avatar id, or null if dismissed.
Future<String?> showAvatarPicker(BuildContext context, {String? selectedId}) {
  return showDialog<String>(
    context: context,
    barrierColor: RColors.scrim,
    builder: (ctx) => Dialog(
      backgroundColor: RColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: Text('Choose your avatar', style: RFonts.h4)),
                IconButton(
                  icon: const Icon(Icons.close, color: RColors.textPrimary),
                  onPressed: () => Navigator.pop(ctx),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Flexible(
              child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              children: AnimalAvatar.all.map((a) {
                final isSelected = a.id == selectedId;
                return GestureDetector(
                  onTap: () => Navigator.pop(ctx, a.id),
                  child: Container(
                    decoration: BoxDecoration(
                      color: a.background,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? RColors.primary : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(a.emoji, style: const TextStyle(fontSize: 36)),
                  ),
                );
              }).toList(),
              ),
            ),
          ],
        ),
        ),
      ),
    ),
  );
}