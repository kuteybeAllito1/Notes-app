// ignore_for_file: unused_import

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn2/Components/CostumTextFieldAdd.dart';
import 'package:learn2/Components/CustomButtom.dart';
import 'package:learn2/Note/ViewNote.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AddNote extends StatefulWidget {
  final String doocId;
  const AddNote({super.key, required this.doocId});

  @override
  State<AddNote> createState() => _AddNote();
}

class _AddNote extends State<AddNote> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;
  
  

  addNote(context) async {
    CollectionReference note = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.doocId)
        .collection("note");
    try {
      if (formstate.currentState!.validate()) {
        isLoading = true;
        setState(() {});

        // ignore: unused_local_variable
        DocumentReference response = await note.add(
          {
            "note": textEditingController.text,
            
          },
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ViewNote(
                  CategorieId: widget.doocId,
                )));
      } else {
        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'Add Categorie Name First',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      isLoading = false;
      setState(() {});
      AwesomeDialog(
        // ignore: use_build_context_synchronously
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'theme Error',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: Form(
        key: formstate,
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  CustomTextFiledAdd(
                    hinttext: 'Enter Note',
                    controller: textEditingController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Add Note Name First";
                      }
                      return null;
                    },
                  ),
                  
                  Custombuttom(
                    text: "Add",
                    onPressed: () {
                      addNote(context);
                    },
                  )
                ],
              ),
      ),
    );
  }
}
