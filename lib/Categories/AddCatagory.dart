import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn2/Components/CostumTextFieldAdd.dart';
import 'package:learn2/Components/CustomButtom.dart';

class Addcatagory extends StatefulWidget {
  const Addcatagory({super.key});

  @override
  State<Addcatagory> createState() => _AddcatagoryState();
}

class _AddcatagoryState extends State<Addcatagory> {
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  bool isLoading = false;

  addCategories() async {
    try {
      if (formstate.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        // ignore: unused_local_variable
        DocumentReference response = await categories.add(
          {
            "name": textEditingController.text,
            "id": FirebaseAuth.instance.currentUser!.uid
          },
        );
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
        title: const Text("Add Categories"),
      ),
      body: Form(
        key: formstate,
        child:isLoading==true? const Center(child: CircularProgressIndicator(),): Column(
          children: [
            CustomTextFiledAdd(
              hinttext: 'Enter Name',
              controller: textEditingController,
              validator: (val) {
                if (val!.isEmpty) {
                  return "Add Categorie Name First";
                }
                return null;
              },
            ),
            Custombuttom(
              text: "Add",
              onPressed: () {
                addCategories();
              },
            )
          ],
        ),
      ),
    );
  }
}
