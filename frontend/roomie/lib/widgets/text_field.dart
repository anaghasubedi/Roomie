import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';

/// A TextFormField wrapper that supports a hint which changes when the
/// field gains focus — e.g. showing a placeholder at rest, and a more
/// specific example or instruction once the user starts typing.
///
/// If [focusedHint] is omitted, it just falls back to [hint] in both
/// states (same as a plain TextFormField).
class RoomieTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? focusedHint;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  const RoomieTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.focusedHint,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.suffixIcon,
  });

  @override
  State<RoomieTextField> createState() => _RoomieTextFieldState();
}

class _RoomieTextFieldState extends State<RoomieTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_isFocused != _focusNode.hasFocus) {
      setState(() => _isFocused = _focusNode.hasFocus);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeHint =
        _isFocused ? (widget.focusedHint ?? widget.hint) : widget.hint;

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: RFonts.body(fontSize: 13, color: RColors.text),
      decoration: RoomieDecor.of(activeHint).copyWith(
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}

class RoomieDecor {
  static InputDecoration of(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: RFonts.body(fontSize: 13, color: RColors.hint),
      filled: true,
      fillColor: RColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: RColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: RColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: RColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: RColors.error, width: 1.5),
      ),
      errorStyle: RFonts.body(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: RColors.error,
      ),
    );
  }
}