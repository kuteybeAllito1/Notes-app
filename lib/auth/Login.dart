import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn2/Components/CustomButtom.dart';
import 'package:learn2/Components/CustomLogoAuth.dart';
import 'package:learn2/Components/CustomTextFiled.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? email;
  TextEditingController? password;
  GlobalKey<FormState> formState = GlobalKey();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // ignore: use_build_context_synchronously
    return Navigator.of(context)
        .pushNamedAndRemoveUntil("HomePage", (route) => false);
  }

  @override
  void initState() {
    email = TextEditingController();
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
                    const Customlogoauth(image: "images/user.png"),
                    Container(
                      height: 15,
                    ),
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 7),
                        child: const Text(
                          "Login to Continue Using The App",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )),
                    CustomTextFiled(
                      hinttext: 'Enter Your Email',
                      controller: email!,
                      text: 'Email',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Text Empty";
                        }
                        return null;
                      },
                    ),
                    CustomTextFiled(
                      hinttext: "Enter Your Password",
                      controller: password!,
                      text: "Password",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Text Empty";
                        }
                        return null;
                      },
                    ),
                    InkWell(
                      onTap: () async {
                        
                        try{
                          // ignore: unused_local_variable
                          final signInMethods = 
                          // ignore: deprecated_member_use
                          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email!.text);
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: email!.text);
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Info',
                          desc: 'We sent you a password reset email, please check your inbox.',
                        ).show();
                        }catch(e){
                          
                        AwesomeDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: 'Info',
                          desc: 'The email you entered is not registered before',
                        ).show();
                      }
                        },
                      child: Container(
                        alignment: Alignment.topRight,
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Custombuttom(
                  text: "Lgoin",
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        // ignore: unused_local_variable
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: email!.text, password: password!.text);
                        // ignore: use_build_context_synchronously
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context)
                              .pushReplacementNamed("HomePage");
                        } else {
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Info',
                            desc: 'Please Verified Youre Email.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'No user found for that email.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        } else if (e.code == 'wrong-password') {
                          AwesomeDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error',
                            desc: 'Wrong password provided for that user.',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }
                      }
                    } else {
                      // ignore: avoid_print
                      print("Eross");
                    }
                  }),
              Container(
                height: 20,
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
                          child: const Text("Or Login With"))),
                  Expanded(
                      child: Container(
                    width: 50,
                    height: 1,
                    color: Colors.grey,
                  )),
                ],
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey[200]),
                    child: InkWell(
                      onTap: () {
                        signInWithGoogle();
                      },
                      child: Image.asset(
                        "images/Google__G__logo.svg.png",
                        height: 40,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey[200]),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "images/Facebook_Logo_(2019).png",
                        height: 40,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey[200]),
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "images/thumbnail.png",
                        height: 40,
                      ),
                    ),
                  )
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed("SignUp");
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Row(
                    children: [
                      Text("Don't Have An Account?"),
                      Text(
                        "Reginster",
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
