import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;

  const CustomFilledButton(
      {super.key, this.onPressed, required this.text, this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FilledButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
    );
  }
}
