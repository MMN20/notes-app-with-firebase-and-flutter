import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/widgets/mybutton.dart';
import 'package:flutter_firebase/widgets/mytextformfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  void register() async {
    if (globalKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        await credential.user!.sendEmailVerification();

        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Email Verification',
          desc: 'We sent an email verification to your email, Please verify it',
          btnOkOnPress: () {},
        ).show();
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     content: Text(
        //         'We sent an email verification to your email, Please verify it')));

        Navigator.pop(context);
      } catch (e) {
        print(
            '================================================================= ${e.toString()}');
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          // title: 'Email Verification',
          desc: 'This email is already in use by another account',
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  String? validator(String? val) {
    if (val == '') {
      return "Can't be empty";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset(
                    'assets/key.png',
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                MyTextFormField(
                  validator: validator,
                  controller: emailController,
                  hintText: 'Enter your email',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                MyTextFormField(
                  validator: validator,
                  controller: passwordController,
                  hintText: 'Enter your password',
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: MyButton(
                    onPressed: register,
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
