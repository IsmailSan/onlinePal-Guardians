import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';


class DropdownListField extends StatelessWidget {
  final String? value;
  final List<Map<String, String>> items;
  final Function(String?) onChanged;
  final String hintText;
  final bool enabled;
  final String? Function(String?)? validator;

  const DropdownListField({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = '',
    this.enabled = true,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayText = items.firstWhere(
          (item) => item['value'] == value,
      orElse: () => {'label': ''},
    )['label'];

    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.indigo),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: grayTextStyle.copyWith(fontSize: 16.sp),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: lightBlueColor),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      style: blackTextStyle.copyWith( // Teks value tetap hitam
        fontSize: 16.sp,
        color: Colors.black,
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item['value'],
          child: Text(
            item['label'] ?? '-',
            style: blackTextStyle.copyWith(fontSize: 16.sp),
          ),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
      validator: validator,
      disabledHint: Text(
        displayText!.isNotEmpty ? displayText : "-",
        style: blackTextStyle.copyWith(fontSize: 16.sp), // Warna tetap hitam saat disabled
      ),
    );
  }
}




