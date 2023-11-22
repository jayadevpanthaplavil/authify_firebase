import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../reusable_widgets/reusable_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,),
        ),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.40,
                        child: Lottie.asset(
                            'assets/lottiefiles/signup_lottie.json')),
                    reusableTextField("Enter Username", Icons.person_outline,
                        false, _usernameTextController),
                    SizedBox(height: 20),
                    reusableTextField("Enter Email Id", Icons.email_outlined,
                        false, _emailTextController),
                    SizedBox(height: 20),
                    reusableTextField("Enter Password", Icons.lock_outline,
                        true, _passwordTextController),
                    SizedBox(height: 20),
                    reusableButton(context, false, () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) async{
                        await FirebaseAuth.instance.currentUser
                            !.updateDisplayName(_usernameTextController.text);
                      }).then((value) {
                        print("Account created successfully");
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
      ),
    );
  }
}
