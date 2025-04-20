import 'package:flutter/material.dart';

class CustomTextFiledAdd extends StatelessWidget {
  final String hinttext;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const CustomTextFiledAdd(
      {super.key, required this.hinttext, required this.controller,required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
          child: TextFormField(
            validator:validator ,
            controller: controller,
            decoration: InputDecoration(
              hintText: hinttext,
              hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 109, 121, 133), width: 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
