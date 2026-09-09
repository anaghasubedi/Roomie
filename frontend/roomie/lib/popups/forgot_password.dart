import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';
import '../widgets/logo_mark.dart';
import '../widgets/field_labels.dart';
import '../widgets/primary_button.dart';
import 'verification.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  /// Shows the forgot-password flow as a centered popup.
  ///
  /// Usage: `ForgotPasswordDialog.show(context);`
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ForgotPasswordDialog(),
    );
  }

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // todo: call backend to send reset code to _emailController.text
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);
    if (!mounted) return;

    final email = _emailController.text.trim();
    Navigator.of(context).pop();
    VerificationDialog.show(
      context,
      email: email,
      mode: VerificationMode.resetPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: RColors.bg,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 16, 28, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: RColors.text,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const Logo(),
                const SizedBox(height: 20),
                Text(
                  'forgot password?',
                  style: RFonts.heading(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: RColors.text,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "enter your email and we'll send\na reset code your way",
                  textAlign: TextAlign.center,
                  style: RFonts.body(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: RColors.primaryMid,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FieldLabel('email'),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: RFonts.body(fontSize: 13, color: RColors.text),
                        decoration: RoomieDecor.of('you@email.com'),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'email is required';
                          }
                          if (!v.contains('@')) return 'enter a valid email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        label: 'send code →',
                        isLoading: _isLoading,
                        onPressed: _handleSend,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}