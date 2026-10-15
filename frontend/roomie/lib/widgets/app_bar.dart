import 'package:flutter/material.dart';
import '../screens/notification.dart';
import '../screens/profile.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

class RoomieAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final bool showBackButton;

  const RoomieAppBar({
    super.key,
    required this.currentIndex,
    this.showBackButton = false,
  });

  static const List<IconData> _icons = [
    Icons.home,
    Icons.calendar_month,
    Icons.receipt_long,
    Icons.cleaning_services,
    Icons.star,
    Icons.celebration,
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: showBackButton ? 0 : 16,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: RColors.textPrimary),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icons[currentIndex], size: 22, color: RColors.primary),
          const SizedBox(width: 15),
          Text(
            'ROOMIE',
            style: RFonts.heading(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: RColors.primary,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                ),
                icon: const Icon(Icons.notifications_outlined, color: RColors.textPrimary),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                ),
                icon: const Icon(Icons.person_outline, color: RColors.textPrimary),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}