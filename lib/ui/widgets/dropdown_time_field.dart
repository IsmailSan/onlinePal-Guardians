import 'package:flutter/material.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class TimeDropdownField extends StatelessWidget {
  final TimeOfDay time;
  final VoidCallback onTap;

  const TimeDropdownField({super.key,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
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
                Text(time.format(context), style: blackTextStyle),
                const Icon(Icons.keyboard_arrow_down, color: Colors.indigo),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



