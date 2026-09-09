import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/fonts.dart';
import 'field_error.dart';
import 'dob_text_field.dart';

class DobPicker extends StatefulWidget {
  final DateTime? selectedDob;
  final String? error;
  final ValueChanged<DateTime?> onChanged;
  final int minAge;

  const DobPicker({
    super.key,
    required this.onChanged,
    this.selectedDob,
    this.error,
    this.minAge = 16,
  });

  @override
  State<DobPicker> createState() => _DobPickerState();
}

class _DobPickerState extends State<DobPicker>
    with SingleTickerProviderStateMixin {
  bool _calOpen = false;
  late final AnimationController _anim;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  static final DateTime _earliestDob = DateTime(1900, 1, 1);

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  DateTime get _maxDate {
    final now = DateTime.now();
    return DateTime(now.year - widget.minAge, now.month, now.day);
  }

  DateTime get _initialCalendarDate {
    final selected = widget.selectedDob;
    if (selected != null && !selected.isAfter(_maxDate)) return selected;
    return _maxDate;
  }

  void _toggleCal() {
    setState(() => _calOpen = !_calOpen);
    _calOpen ? _anim.forward() : _anim.reverse();
  }

  void _closeCal() {
    setState(() => _calOpen = false);
    _anim.reverse();
  }

  void _onTextChanged(DateTime? date) {
    if (date != null && date.isAfter(_maxDate)) return;
    widget.onChanged(date);
  }

  void _onCalendarDateChanged(DateTime date) {
    widget.onChanged(date);
    _closeCal();
  }

  int _calcAge(DateTime dob) {
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DobTextField(
          value: widget.selectedDob,
          onChanged: _onTextChanged,
          onCalendarTap: _toggleCal,
          calOpen: _calOpen,
          hasError: widget.error != null,
        ),
        if (widget.error != null) ...[
          const SizedBox(height: 5),
          FieldError(message: widget.error!),
        ] else if (widget.selectedDob != null) ...[
          const SizedBox(height: 5),
          Text(
            'age: ${_calcAge(widget.selectedDob!)} years',
            style: RFonts.body(fontSize: 11, color: RColors.primaryMid),
          ),
        ],
        if (_calOpen) ...[
          const SizedBox(height: 8),
          FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Container(
                decoration: BoxDecoration(
                  color: RColors.surface,
                  border: Border.all(color: RColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: CalendarDatePicker(
                  initialDate: _initialCalendarDate,
                  firstDate: _earliestDob,
                  lastDate: _maxDate,
                  onDateChanged: _onCalendarDateChanged,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}