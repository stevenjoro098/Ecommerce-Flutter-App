import 'package:flutter/material.dart';

class IconButtonWithText extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  const IconButtonWithText({
    required this.imagePath,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              imagePath,
            ),
          ),
          const SizedBox(height: 4.0), // Spacing between icon and text
          Text(
            label,
            style: const TextStyle(fontSize: 14.0, color: Colors.blue, fontWeight: FontWeight.w900, letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}