import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';
import '../popups/avatar_picker.dart';
import '../popups/logout_confirm.dart';
import '../widgets/info_row.dart';
import '../widgets/primary_button.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_toprow.dart';
import '../widgets/vibe_status.dart';
import '../popups/leave_confirm.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Vibe _vibe = Vibe.available;
  String? _avatarId = 'fox'; // todo: load from user profile

  // todo: replace with real user/home data from your provider/API.
  final String _name = 'Kriti';
  final String _dob = '27 May 2005';
  final String _email = 'krka@gmail.com';
  final String _homeName = 'Pagal Haru';
  final String _subSpaceName = 'Homiee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 20, 20),
          child: Column(
            children: [
              ProfileTopRow(
                vibe: _vibe,
                onVibeChanged: (v) {
                  // todo: persist vibe to backend
                  setState(() => _vibe = v);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text('Welcome $_name', style: RFonts.h3),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileAvatar(
                            avatarId: _avatarId,
                            onTap: () async {
                              final id = await showAvatarPicker(
                                context,
                                selectedId: _avatarId,
                              );
                              if (id != null) {
                                // todo: persist avatar id to backend
                                setState(() => _avatarId = id);
                              }
                            },
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InfoRow(label: 'DOB', value: _dob),
                                InfoRow(label: 'Email', value: _email),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'Edit',
                        onPressed: () {
                          // todo: edit profile
                        },
                      ),
                      const SizedBox(height: 28),
                      InfoRow(label: 'Home', value: _homeName),
                      InfoRow(label: 'Sub-space', value: _subSpaceName),
                      // todo: "org./avg." row once clarified
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Leave',
                        onPressed: () async {
                          final confirmed = await showLeaveDialog(
                            context,
                            title: 'Leave?',
                            message: 'Someone will need to invite you into this space again',
                            leavelabel: 'Leave',
                          );
                          if (!confirmed || !context.mounted) return;
                          // todo: clear tokens/session, then navigate to login
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Logout',
                        onPressed: () async {
                          final confirmed = await showConfirmDialog(
                            context,
                            title: 'Log out?',
                            message: 'You will need to sign in again to use Roomie.',
                            confirmLabel: 'Logout',
                          );
                          if (!confirmed || !context.mounted) return;
                          // todo: clear tokens/session, then navigate to login
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}