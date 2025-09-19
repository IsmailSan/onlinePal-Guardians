import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;
  final double width;
  final double height;

  const MenuItem({
    super.key,
    required this.assetPath,
    required this.onTap,
    this.width = 80.0,  // Default width
    this.height = 80.0, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
