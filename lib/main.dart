import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learn2/Categories/AddCatagory.dart';
import 'package:learn2/HomePage.dart';
import 'package:learn2/auth/Login.dart';
import 'package:learn2/auth/SignUp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MyApp();
}

class _MyApp extends State<Main> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print('User is currently signed out!');
      } else {
        // ignore: avoid_print
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.blueGrey),
          backgroundColor: Colors.grey[200],
          titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.blueGrey),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            side: BorderSide(
              color: Colors.grey,
              width: 3,
            ),
          ),
        ),
      ),
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const Homepage()
          : const Login(),
      routes: {
        "SignUp": (context) => const SignUp(),
        "Login": (context) => const Login(),
        "HomePage": (context) => const Homepage(),
        "Addcatagory": (context) => const Addcatagory(),
      },
    );
  }
}
