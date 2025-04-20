import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn2/Components/CostumTextFieldAdd.dart';
import 'package:learn2/Components/CustomButtom.dart';
import 'package:learn2/Note/ViewNote.dart';

class EditNote extends StatefulWidget {
  final String notedoocId;
  final String categoriId;
  final String oldeName;

  const EditNote(
      {super.key,
      required this.notedoocId,
      required this.categoriId,
      required this.oldeName});

  @override
  State<EditNote> createState() => _EditNote();
}

class _EditNote extends State<EditNote> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  bool isLoading = false;

  addNote() async {
    CollectionReference note = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoriId)
        .collection("note");
    try {
      if (formstate.currentState!.validate()) {
        isLoading = true;
        setState(() {});

        // ignore: unused_local_variable
        await note
            .doc(widget.notedoocId)
            .update({"note": textEditingController.text});
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ViewNote(
                  CategorieId: widget.categoriId,
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
  void initState() {
    textEditingController.text = widget.oldeName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
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
                        return "Edit Note Name First";
                      }
                      return null;
                    },
                  ),
                  Custombuttom(
                    text: "Edit",
                    onPressed: () {
                      addNote();
                    },
                  )
                ],
              ),
      ),
    );
  }
}
