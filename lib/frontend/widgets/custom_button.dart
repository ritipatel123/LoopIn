import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color; // Add color parameter

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = CupertinoColors.black, // Default color to black
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: color, // Use the custom color
      borderRadius: BorderRadius.circular(25),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: CupertinoColors.white, // Ensure white text for contrast
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

