import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class CustomFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? helperText;
  final bool isShowLabel;
  final bool isPassword;
  final bool isNumeric;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool? readOnly;
  final bool? enabled;
  final int? minLines;
  final int? maxLines;
  final FormFieldValidator<String>? validator;

  const CustomFormField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.helperText,
    this.isShowLabel = true,
    this.isPassword = false,
    this.isNumeric = false,
    this.onFieldSubmitted,
    this.focusNode,
    this.readOnly,
    this.enabled,
    this.minLines,
    this.maxLines,
    this.validator,
  }) : super(key: key);

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late FocusNode _focusNode;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowLabel)
          Text(
            widget.label,
            style: blackTextStyle.copyWith(
              fontSize: 20.sp,
              fontWeight: regular,
            ),
          ),
        if (widget.isShowLabel) const SizedBox(height: 8),
        TextFormField(
          focusNode: _focusNode,
          obscureText: widget.isPassword ? _obscureText : false,
          controller: controller,
          readOnly: widget.readOnly ?? false,
          enabled: widget.enabled ?? true,
          keyboardType:
          widget.isNumeric ? TextInputType.number : TextInputType.multiline,
          inputFormatters: widget.isNumeric
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          minLines: widget.minLines ?? 1,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: grayTextStyle,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.w,
              horizontal: 16.h,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: lightBlueColor, width: 1),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: lightBlueColor, width: 1),
            ),
            focusedBorder: widget.enabled == false
                ? InputBorder.none
                : UnderlineInputBorder(
              borderSide: BorderSide(color: lightBlueColor, width: 1),
            ),
            suffixIcon: controller != null && widget.readOnly != true
                ? widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : IconButton(
              icon: Icon(Icons.cancel_rounded,
                  color: strongPurpleColor),
              onPressed: () {
                controller.clear();
                _focusNode.requestFocus();
              },
            )
                : null,
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
        SizedBox(height: 4.h),
        if (widget.helperText != null && widget.helperText!.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            widget.helperText!,
            style:
            grayTextStyle.copyWith(fontSize: 14.sp, fontWeight: regular),
          ),
        ],
      ],
    );
  }
}

