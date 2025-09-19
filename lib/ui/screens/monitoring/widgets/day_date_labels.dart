import 'package:flutter/material.dart';

class DayDateLabels extends StatelessWidget {
  final List<String> days;
  final List<String> dates;

  const DayDateLabels({
    super.key,
    required this.days,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: const EdgeInsets.only(left: 120),
      child: Row(
        children: List.generate(days.length, (index) {
          return Expanded(
            child: Column(
              children: [
                Text(
                  days[index],
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  dates[index],
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
