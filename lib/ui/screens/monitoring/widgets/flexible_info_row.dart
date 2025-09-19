import 'package:flutter/material.dart';

class FlexibleInfoRow extends StatelessWidget {
  final List<Widget> cells;
  final List<double?> textWidths;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment crossAlignment;
  final double spacing;
  final EdgeInsets padding;
  final Color? underlineColor;

  const FlexibleInfoRow({
    super.key,
    required this.cells,
    this.textWidths = const [],
    this.alignment = MainAxisAlignment.spaceBetween,
    this.crossAlignment = CrossAxisAlignment.center,
    this.spacing = 4.0,
    this.padding = const EdgeInsets.symmetric(vertical: 6.0),
    this.underlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: alignment,
            crossAxisAlignment: crossAlignment,
            children: List.generate(cells.length, (index) {
              final width = index < textWidths.length ? textWidths[index] : null;

              return Padding(
                padding: EdgeInsets.only(right: spacing),
                child: width != null
                    ? SizedBox(width: width, child: cells[index])
                    : Expanded(child: cells[index]),
              );
            }),
          ),
          if (underlineColor != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Divider(
                thickness: 1,
                color: underlineColor,
              ),
            ),
        ],
      ),
    );
  }
}
