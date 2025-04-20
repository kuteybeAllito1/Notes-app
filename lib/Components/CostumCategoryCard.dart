import 'package:flutter/material.dart';

class AddCategoryCard extends StatelessWidget {
  final String image;
  final String text;
  const AddCategoryCard({super.key, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      child: Column(
        children: [
          Container(
            // ignore: sort_child_properties_last
            child: Image.asset(image),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          ),
          Text(
            text,
            // ignore: prefer_const_constructors
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
