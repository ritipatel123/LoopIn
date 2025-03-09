import 'package:flutter/cupertino.dart';

class InputField extends StatelessWidget {
  final String placeholder;
  final bool obscureText;

  const InputField({
    super.key,
    required this.placeholder,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholder,
      obscureText: obscureText,
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6, // Light background color
        borderRadius: BorderRadius.circular(25), // Oval shape
        border: Border.all(
          color: CupertinoColors.systemGrey, // Subtle border
          width: 1.5,
        ),
      ),
      style: TextStyle(fontSize: 16),
    );
  }
}

