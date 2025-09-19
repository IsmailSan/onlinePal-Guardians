import 'package:flutter/material.dart';

class PointBarChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final Color positiveColor;
  final Color negativeColor;

  const PointBarChart({
    super.key,
    required this.data,
    required this.labels,
    this.positiveColor = Colors.amber,
    this.negativeColor = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    final double maxValue = data.map((e) => e.abs()).reduce((a, b) => a > b ? a : b);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 160,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartHeight = constraints.maxHeight;
                final baseline = chartHeight / 2;
                final barMaxHeight = chartHeight / 2;
                final barWidth = 16.0;

                return Stack(
                  children: [
                    // Garis tengah
                    Positioned(
                      top: baseline,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                    ),

                    // Bar dan label
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(data.length, (index) {
                        final value = data[index];
                        final label = labels.length > index ? labels[index] : '';
                        final isNegative = value < 0;
                        final barHeight = (value.abs() / maxValue) * barMaxHeight;
                        final barTop = isNegative ? baseline : baseline - barHeight;
                        final barBottom = isNegative ? baseline + barHeight : baseline;

                        return Expanded(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Bar
                              Positioned(
                                top: barTop,
                                child: Container(
                                  height: barHeight,
                                  width: barWidth,
                                  decoration: BoxDecoration(
                                    color: isNegative ? negativeColor : positiveColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),

                              // Label — selalu 5px dari bar terbawah
                              Positioned(
                                top: barBottom + 5,
                                child: SizedBox(
                                  width: barWidth * 3,
                                  child: Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
