import 'package:flutter/material.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class FlexibleDropdownField extends StatelessWidget {
  final String valueText;
  final VoidCallback onTap;

  const FlexibleDropdownField({
    super.key,
    required this.valueText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: lightBlueColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(valueText, style: blackTextStyle),
            const Icon(Icons.keyboard_arrow_down, color: Colors.indigo),
          ],
        ),
      ),
    );
  }
}
