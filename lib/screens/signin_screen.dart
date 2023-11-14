import 'package:authify_firebase/reusable_widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.50,
                      child:
                          Lottie.asset('assets/lottiefiles/auth_lottie.json')),
                  reusableTextField("Enter Email Id", Icons.email_outlined,
                      false, _emailTextController),
                  SizedBox(height: 20),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(height: 20),
                  reusableButton(context, true, () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      print("Account logged successfully");
                      Navigator.pushNamed(context, '/home_screen');
                    }).onError((error, stackTrace) {
                      print("Error : ${error.toString()}");
                    });
                  }),
                  SizedBox(height: 20),
                  signUpOption(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
