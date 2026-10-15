import 'package:flutter/material.dart';
import '../themes/colors.dart';

class AnimalAvatar {
  final String id; // store this string on the backend
  final String emoji;
  final Color background;

  const AnimalAvatar(this.id, this.emoji, this.background);

  static const List<AnimalAvatar> all = [
    AnimalAvatar('fox', '🦊', RColors.warningLight),
    AnimalAvatar('cat', '🐱', RColors.primaryContainer),
    AnimalAvatar('dog', '🐶', RColors.infoLight),
    AnimalAvatar('panda', '🐼', RColors.primaryLight),
    AnimalAvatar('frog', '🐸', RColors.successLight),
    AnimalAvatar('owl', '🦉', RColors.warningLight),
    AnimalAvatar('penguin', '🐧', RColors.infoLight),
    AnimalAvatar('lion', '🦁', RColors.warningLight),
    AnimalAvatar('koala', '🐨', RColors.primaryLight),
    AnimalAvatar('rabbit', '🐰', RColors.errorLight),
    AnimalAvatar('bear', '🐻', RColors.primaryContainer),
    AnimalAvatar('tiger', '🐯', RColors.warningLight),
  ];

  static AnimalAvatar? byId(String? id) {
    for (final a in all) {
      if (a.id == id) return a;
    }
    return null;
  }
}

class ProfileAvatar extends StatelessWidget {
  final String? avatarId;
  final String? imageUrl;
  final double radius;
  final VoidCallback? onTap;

  const ProfileAvatar({
    super.key,
    this.avatarId,
    this.imageUrl,
    this.radius = 36,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final animal = AnimalAvatar.byId(avatarId);
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;

    final Widget avatar = Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: RColors.border, width: 1.5),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: animal?.background ?? RColors.primaryContainer,
        backgroundImage:
            animal == null && hasImage ? NetworkImage(imageUrl!) : null,
        child: animal != null
            ? Text(animal.emoji, style: TextStyle(fontSize: radius * 1.05))
            : (hasImage
                ? null
                : Icon(Icons.person, size: radius, color: RColors.primary)),
      ),
    );

    if (onTap == null) return avatar;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: RColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: RColors.surface, width: 2),
              ),
              child: const Icon(Icons.edit, size: 12, color: RColors.buttonText),
            ),
          ),
        ],
      ),
    );
  }
}