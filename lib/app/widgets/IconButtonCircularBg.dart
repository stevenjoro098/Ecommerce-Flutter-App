import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const CircularIconButton({
    required this.icon,
    required this.onPressed,
    this.backgroundColor = Colors.white60,
    this.iconColor = Colors.white,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).primaryColor;
    final Color iconColor = Theme.of(context).colorScheme.onPrimary;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.5,
        ),
      ),
    );
  }
}
