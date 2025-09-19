import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTimePickerDialog extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final void Function(TimeOfDay) onTimeSelected;

  const CupertinoTimePickerDialog({
    super.key,
    required this.initialHour,
    required this.initialMinute,
    required this.onTimeSelected,
  });

  @override
  State<CupertinoTimePickerDialog> createState() => _CupertinoTimePickerDialogState();
}

class _CupertinoTimePickerDialogState extends State<CupertinoTimePickerDialog> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialHour;
    selectedMinute = widget.initialMinute;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(16),
      content: SizedBox(
        height: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: selectedHour),
                itemExtent: 40,
                useMagnifier: true,
                onSelectedItemChanged: (index) => selectedHour = index,
                children: List.generate(24, (i) => Center(child: Text(i.toString().padLeft(2, '0')))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(":", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              width: 100,
              child: CupertinoPicker(
                scrollController: FixedExtentScrollController(initialItem: widget.initialMinute ~/ 5),
                itemExtent: 40,
                useMagnifier: true,
                onSelectedItemChanged: (index) => selectedMinute = index * 5,
                children: List.generate(12, (i) {
                  int minute = i * 5;
                  return Center(child: Text(minute.toString().padLeft(2, '0')));
                }),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              widget.onTimeSelected(TimeOfDay(hour: selectedHour, minute: selectedMinute));
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Pilih"),
          ),
        )
      ],
    );
  }
}
