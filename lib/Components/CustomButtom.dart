import 'package:flutter/material.dart';

class Custombuttom extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const Custombuttom({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.blue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 44,
      child: Text(text),
    );
  }
}


