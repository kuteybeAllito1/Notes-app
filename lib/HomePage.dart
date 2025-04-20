// ignore_for_file: prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn2/Categories/UpdateCategories.dart';
import 'package:learn2/Components/CostumCategoryCard.dart';
import 'package:learn2/Note/ViewNote.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyApp();
}

class _MyApp extends State<Homepage> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getDataFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getDataFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("Addcatagory");
          },
          backgroundColor: Colors.grey,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("Login", (route) => false);
                },
                icon: const Icon(Icons.exit_to_app))
          ],
          title: const Text("Home page"),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewNote(
                                CategorieId: data[index].id,
                              )));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Warning',
                        desc:
                            'Choose the operation you want to delete or modify the category.',
                        btnCancelText: "Delete",
                        btnOkText: "Update",
                        btnCancelOnPress: () async {
                          await FirebaseFirestore.instance
                              .collection("categories")
                              .doc(data[index].id)
                              .delete();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context)
                              .pushReplacementNamed("HomePage");
                        },
                        btnOkOnPress: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Updatecatagory(
                                    doc: data[index].id,
                                    oldeName: data[index]["name"],
                                  )));
                        },
                      ).show();
                    },
                    child: AddCategoryCard(
                      image: 'images/free-blue-folder-icon-11450-thumb.png',
                      text: data[index]["name"],
                    ),
                  );
                },
                // ignore: prefer_const_literals_to_create_immutables
              ));
  }
}

