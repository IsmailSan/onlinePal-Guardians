import 'package:flutter/material.dart';

class ScreenTimeBarChart extends StatelessWidget {
  final String title;
  final List<double> data;
  final Color barColor;

  const ScreenTimeBarChart({
    super.key,
    required this.title,
    required this.data,
    this.barColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    // kalau data kosong, kasih default 1 supaya ga crash
    double maxY = data.isNotEmpty ? data.reduce((a, b) => a > b ? a : b) : 1;

    // kalau semua value = 0, hindari division by zero
    if (maxY == 0) maxY = 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 110,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double barAreaHeight = constraints.maxHeight - 30;
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: data.map((value) {
                          final height = (value / maxY) * barAreaHeight;

                          return Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: height.isNaN
                                    ? 0
                                    : height, // amankan di sini juga
                                width: 20,
                                decoration: BoxDecoration(
                                  color: barColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(height: 1, color: Colors.black),
                    const SizedBox(height: 6),
                    Row(
                      children: data.map((value) {
                        return Expanded(
                          child: Text(
                            '${value.toInt()} min',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
