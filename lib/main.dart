import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/home_page.dart';
import 'package:flutter_firebase/pages/login_page.dart';
import 'package:flutter_firebase/pages/signup_page.dart';
import 'package:flutter_firebase/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isThereCurrentUser = FirebaseAuth.instance.currentUser != null;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: isThereCurrentUser
          ? HomePage(
              collectionReference:
                  FirebaseFirestore.instance.collection('data'),
            )
          : const LoginPage(),
      routes: {
        'login': (c) => const LoginPage(),
        'signup': (c) => const SignUpPage(),
        'homepage': (c) => HomePage(
              collectionReference:
                  FirebaseFirestore.instance.collection('data'),
            )
      },
    );
  }
}
