import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/colors.dart';

/// Call this from CreateHomeScreen after a successful home creation.
/// [inviteCode] and [inviteLink] come from the backend response.
Future<void> showInviteRoommatesDialog(
  BuildContext context, {
  required String inviteCode,
  required String inviteLink,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => InviteRoommatesDialog(
      inviteCode: inviteCode,
      inviteLink: inviteLink,
    ),
  );
}

class InviteRoommatesDialog extends StatefulWidget {
  const InviteRoommatesDialog({
    super.key,
    required this.inviteCode,
    required this.inviteLink,
  });

  final String inviteCode;
  final String inviteLink;

  @override
  State<InviteRoommatesDialog> createState() => _InviteRoommatesDialogState();
}

class _InviteRoommatesDialogState extends State<InviteRoommatesDialog> {
  bool _codeCopied = false;
  bool _linkCopied = false;

  Future<void> _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.inviteCode));
    setState(() => _codeCopied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _codeCopied = false);
  }

  Future<void> _copyLink() async {
    await Clipboard.setData(ClipboardData(text: widget.inviteLink));
    setState(() => _linkCopied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _linkCopied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: RColors.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Icon
            const Center(
              child: CircleAvatar(
                radius: 28,
                backgroundColor: RColors.primaryLight,
                child: Icon(Icons.group_add_outlined,
                    size: 28, color: RColors.primary),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Invite your roomies',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: RColors.primary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Share the code or link so your roommates can join the home.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: RColors.primaryMid),
            ),
            const SizedBox(height: 24),

            _CopyTile(
              label: 'Invite code',
              value: widget.inviteCode,
              copied: _codeCopied,
              onCopy: _copyCode,
            ),
            const SizedBox(height: 12),

            _CopyTile(
              label: 'Invite link',
              value: widget.inviteLink,
              copied: _linkCopied,
              onCopy: _copyLink,
              isLink: true,
            ),
            const SizedBox(height: 28),

            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: RColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _CopyTile extends StatelessWidget {
  const _CopyTile({
    required this.label,
    required this.value,
    required this.copied,
    required this.onCopy,
    this.isLink = false,
  });

  final String label;
  final String value;
  final bool copied;
  final VoidCallback onCopy;
  final bool isLink;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: RColors.primaryMid,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: RColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: RColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: isLink ? 12 : 15,
                    fontWeight:
                        isLink ? FontWeight.w400 : FontWeight.w600,
                    color: RColors.primary,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onCopy,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: copied
                      ? const Icon(Icons.check_rounded,
                          key: ValueKey('check'), size: 20, color: Colors.green)
                      : const Icon(Icons.copy_rounded,
                          key: ValueKey('copy'),
                          size: 20,
                          color: RColors.primaryMid),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}