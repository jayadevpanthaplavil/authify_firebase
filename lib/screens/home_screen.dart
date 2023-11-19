import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
    String username="Name ${user?.displayName}";
    String? profileURL=user?.photoURL;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(profileURL!),
            Text(username),
            ElevatedButton(
              onPressed: (){
                GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.pushNamed(context, '/');
                });
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }


}
