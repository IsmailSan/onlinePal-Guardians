import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class PointSelectorField extends StatefulWidget {
  final TextEditingController controller;
  final int step;
  final int minValue;
  final int maxValue;
  final bool readOnly;
  final bool multiplyByTen;
  final String mode; // 'plus' or 'minus'

  const PointSelectorField({
    super.key,
    required this.controller,
    this.step = 1,
    this.minValue = 0,
    this.maxValue = 999999,
    this.readOnly = false,
    this.multiplyByTen = false,
    this.mode = 'plus',
  });

  @override
  State<PointSelectorField> createState() => _PointSelectorFieldState();
}

class _PointSelectorFieldState extends State<PointSelectorField> {
  void _increment() {
    final raw = widget.controller.text.replaceAll('-', '');
    final current = int.tryParse(raw) ?? 0;
    final step = widget.multiplyByTen ? widget.step * 10 : widget.step;
    final newValue = (current + step).clamp(widget.minValue.abs(), widget.maxValue);

    widget.controller.text = (widget.mode == 'minus' && newValue != 0)
        ? '-$newValue'
        : newValue.toString();
  }

  void _decrement() {
    final raw = widget.controller.text.replaceAll('-', '');
    final current = int.tryParse(raw) ?? 0;
    final step = widget.multiplyByTen ? widget.step * 10 : widget.step;
    final newValue = (current - step).clamp(widget.minValue.abs(), widget.maxValue);

    widget.controller.text = (widget.mode == 'minus' && newValue != 0)
        ? '-$newValue'
        : newValue.toString();
  }


  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty) {
      widget.controller.text = widget.minValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: '0',
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: lightBlueColor, width: 1),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: lightBlueColor, width: 1),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: lightBlueColor, width: 1),
        ),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: widget.readOnly ? null : _decrement,
              icon: Image.asset(
                'assets/decrement_icon.png',
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
            IconButton(
              onPressed: widget.readOnly ? null : _increment,
              icon: Image.asset(
                'assets/increment_icon.png',
                width: 20,
                height: 20,
                color: Colors.black,
              ),
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
