import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn2/Components/CostumTextFieldAdd.dart';
import 'package:learn2/Components/CustomButtom.dart';

class Updatecatagory extends StatefulWidget {
  final String doc;
  final String oldeName;
  const Updatecatagory({super.key, required this.doc, required this.oldeName});

  @override
  State<Updatecatagory> createState() => _UpdatecatagoryState();
}

class _UpdatecatagoryState extends State<Updatecatagory> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  bool isLoading = false;

  // ignore: non_constant_identifier_names
  UpdateCategories() async {
    try {
      if (formstate.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        await categories
            .doc(widget.doc)
            .update({"name": textEditingController.text});
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil("HomePage", (route) => false);
      } else {
        AwesomeDialog(
          // ignore: use_build_context_synchronously
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'write New Categorie Name First',
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
        title: const Text("Update Categories"),
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
                    hinttext: 'Enter Name',
                    controller: textEditingController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "write New Categorie Name First";
                      }
                      return null;
                    },
                  ),
                  Custombuttom(
                    text: "Update",
                    onPressed: () {
                      UpdateCategories();
                    },
                  )
                ],
              ),
      ),
    );
  }
}
