import 'package:flutter/material.dart';

class Customlogoauth extends StatelessWidget {
  final String image;
  const Customlogoauth({super.key,required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 90,
        height: 90,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(70)),
        child: Image.asset(
          image,
        ),
      ),
    );
  }
}
