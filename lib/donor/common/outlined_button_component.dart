import 'package:flutter/material.dart';

class OutlinedButtonComponent extends StatelessWidget {
  final String buttonText; // Text for the button
  final VoidCallback onPressed; // Callback when button is pressed
  final Color backgroundColor; // Background color of the button
  final Color foregroundColor; // Text color of the button

  const OutlinedButtonComponent({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor = Colors.white, // Default background color
    this.foregroundColor = Colors.black, // Default text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
