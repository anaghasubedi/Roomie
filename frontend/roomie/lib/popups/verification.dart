import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';
import '../widgets/logo_mark.dart';
import '../widgets/otp_input.dart';
import '../widgets/resend_text.dart';
import '../widgets/verification_subtitle.dart';
import '../widgets/primary_button.dart';
import 'reset_password.dart';

/// Controls what happens after a successful verification.
enum VerificationMode {
  /// Default: account creation / email confirmation.
  emailVerification,

  /// Forgot-password flow: navigate to ResetPasswordScreen.
  resetPassword,
}

class VerificationDialog extends StatefulWidget {
  final String email;

  /// Defaults to [VerificationMode.emailVerification].
  final VerificationMode mode;

  const VerificationDialog({
    super.key,
    required this.email,
    this.mode = VerificationMode.emailVerification,
  });

  /// Shows the verification flow as a centered popup.
  ///
  /// Usage: `VerificationDialog.show(context, email: email);`
  static Future<void> show(
    BuildContext context, {
    required String email,
    VerificationMode mode = VerificationMode.emailVerification,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VerificationDialog(email: email, mode: mode),
    );
  }

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
  static const int _codeLength = 6;

  final List<TextEditingController> _controllers = List.generate(
    _codeLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _codeLength,
    (_) => FocusNode(),
  );

  bool _isLoading = false;
  bool _hasError = false;
  int _resendCountdown = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendCountdown = 30;
      _canResend = false;
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _resendCountdown--);
      if (_resendCountdown <= 0) {
        setState(() => _canResend = true);
        return false;
      }
      return true;
    });
  }

  void _onResend() {
    if (!_canResend) return;
    // todo: call backend to resend code (use widget.mode to pick the right endpoint)
    _clearAll();
    _startResendTimer();
    _focusNodes[0].requestFocus();
  }

  void _onChanged(String value, int index) {
    setState(() => _hasError = false);

    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < _codeLength && i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
      final nextIndex = digits.length < _codeLength
          ? digits.length
          : _codeLength - 1;
      _focusNodes[nextIndex].requestFocus();
      _tryAutoVerify();
      return;
    }

    if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    if (_isCodeComplete()) _tryAutoVerify();
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  bool _isCodeComplete() => _controllers.every((c) => c.text.isNotEmpty);

  String get _fullCode => _controllers.map((c) => c.text).join();

  void _tryAutoVerify() {
    if (_isCodeComplete()) _handleVerify();
  }

  void _clearAll() {
    for (final c in _controllers) {
      c.clear();
    }
    setState(() => _hasError = false);
  }

  Future<void> _handleVerify() async {
    if (!_isCodeComplete()) return;
    setState(() => _isLoading = true);

    // todo: send _fullCode + widget.mode to the appropriate backend endpoint
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);
    if (!mounted) return;

    // Simulate wrong code — remove when backend is connected
    final isValid = _fullCode != '000000';

    if (isValid) {
      _onSuccess();
    } else {
      setState(() => _hasError = true);
      _clearAll();
      _focusNodes[0].requestFocus();
    }
  }

  void _onSuccess() {
    switch (widget.mode) {
      case VerificationMode.resetPassword:
        // Close this popup first, then open the next one.
        Navigator.of(context).pop();
        ResetPasswordDialog.show(context, email: widget.email);
      case VerificationMode.emailVerification:
        // todo: pop and navigate to HomeSetupScreen
        Navigator.of(context).pop();
        break;
    }
  }

  // Title and subtitle copy differ per mode
  String get _title => switch (widget.mode) {
    VerificationMode.resetPassword => 'check your email',
    VerificationMode.emailVerification => 'check your email',
  };

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
                  _title,
                  style: RFonts.heading(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: RColors.text,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),
                VerificationSubtitle(email: widget.email),
                const SizedBox(height: 32),
                OtpInput(
                  controllers: _controllers,
                  focusNodes: _focusNodes,
                  hasError: _hasError,
                  onChanged: _onChanged,
                  onKeyEvent: _onKeyEvent,
                ),
                const SizedBox(height: 28),
                PrimaryButton(
                  label: 'verify →',
                  isLoading: _isLoading,
                  onPressed: _isCodeComplete() ? _handleVerify : null,
                ),
                const SizedBox(height: 20),
                ResendText(
                  canResend: _canResend,
                  countdown: _resendCountdown,
                  onResend: _onResend,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}