import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDurationPickerDialog extends StatefulWidget {
  final int initialDuration; // dalam menit
  final void Function(int) onDurationSelected;

  const CupertinoDurationPickerDialog({
    super.key,
    required this.initialDuration,
    required this.onDurationSelected,
  });

  @override
  State<CupertinoDurationPickerDialog> createState() => _CupertinoDurationPickerDialogState();
}

class _CupertinoDurationPickerDialogState extends State<CupertinoDurationPickerDialog> {
  late int selectedDuration;

  final List<int> durationOptions = [0, 30, 60, 90, 120];

  @override
  void initState() {
    super.initState();
    selectedDuration = widget.initialDuration;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(16),
      content: SizedBox(
        height: 250,
        child: CupertinoPicker(
          scrollController: FixedExtentScrollController(
            initialItem: durationOptions.indexOf(selectedDuration),
          ),
          itemExtent: 40,
          useMagnifier: true,
          onSelectedItemChanged: (index) {
            selectedDuration = durationOptions[index];
          },
          children: durationOptions.map((minute) {
            return Center(
              child: Text(
                "$minute Min",
                style: const TextStyle(fontSize: 20),
              ),
            );
          }).toList(),
        ),
      ),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              widget.onDurationSelected(selectedDuration);
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
