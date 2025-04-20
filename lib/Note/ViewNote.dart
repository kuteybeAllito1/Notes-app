// ignore_for_file: prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn2/Note/AddNote.dart';
import 'package:learn2/Note/EditNote.dart';

class ViewNote extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String CategorieId;
  // ignore: non_constant_identifier_names
  const ViewNote({super.key, required this.CategorieId});

  @override
  State<ViewNote> createState() => _ViewNote();
}

class _ViewNote extends State<ViewNote> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getDataFirestore() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.CategorieId)
        .collection("note")
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddNote(
                      doocId: widget.CategorieId,
                    )));
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
          title: const Text("View Note"),
        ),
        // ignore: deprecated_member_use
        body: WillPopScope(
            child: isLoading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onLongPress: () {
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: 'Warning',
                            desc: 'Are You Shure You want to Delete This note.',
                            btnCancelOnPress: () async {},
                            btnOkOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection("categories")
                                  .doc(widget.CategorieId)
                                  .collection("note")
                                  .doc(data[index].id)
                                  .delete();
                          
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => ViewNote(
                                          CategorieId: widget.CategorieId)));
                            },
                          ).show();
                        },
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditNote(
                                    notedoocId: data[index].id,
                                    categoriId: widget.CategorieId,
                                    oldeName: data[index]["note"],
                                  )));
                        },
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  data[index]["note"],
                                  style: TextStyle(fontSize: 20),
                                ),
                                
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    // ignore: prefer_const_literals_to_create_immutables
                  ),
            onWillPop: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("HomePage", (route) => false);
              return Future.value(false);
            }));
  }
}

