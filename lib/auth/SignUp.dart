import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn2/Components/CustomButtom.dart';
import 'package:learn2/Components/CustomLogoAuth.dart';
import 'package:learn2/Components/CustomTextFiled.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController? userName;
  TextEditingController? email;
  TextEditingController? password;
  GlobalKey<FormState> formState = GlobalKey();
  @override
  void initState() {
    email = TextEditingController();
    userName = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Form(
                key: formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 10,
                    ),
                    const Customlogoauth(image: "images/SignUp.png"),
                    Container(
                      height: 15,
                    ),
                    const Text(
                      "SignUp",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 7),
                        child: const Text(
                          "SignUp to Continue Using The App",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )),
                    CustomTextFiled(
                        hinttext: 'Enter Your UserName',
                        controller: userName!,
                        text: 'UserName',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Text Empty";
                          }
                          return null;
                        }),
                    CustomTextFiled(
                        hinttext: 'Enter Your Email',
                        controller: email!,
                        text: 'Email',
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Text Empty";
                          }
                          return null;
                        }),
                    CustomTextFiled(
                        hinttext: "Enter Your Password",
                        controller: password!,
                        text: "Password",
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Text Empty";
                          }
                          return null;
                        }),
                    Container(
                      height: 30,
                    )
                  ],
                ),
              ),
              Custombuttom(
                  text: "SignUp",
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        // ignore: unused_local_variable
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email!.text,
                          password: password!.text,
                        );
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushReplacementNamed("Login");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The password provided is too weak.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        } else if (e.code == 'email-already-in-use') {
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'The account already exists for that email.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }
                      } catch (e) {
                        // ignore: avoid_print
                        print(e);
                      }
                    } else {
                      // ignore: avoid_print
                      print("Erros");
                    }
                  }),
              Container(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    width: 50,
                    height: 1,
                    color: Colors.grey,
                  )),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: const Text("Or Login"))),
                  Expanded(
                      child: Container(
                    width: 50,
                    height: 1,
                    color: Colors.grey,
                  )),
                ],
              ),
              Container(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("Login");
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Row(
                    children: [
                      Text("Have An Account   "),
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
