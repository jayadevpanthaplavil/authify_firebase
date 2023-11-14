import 'package:authify_firebase/screens/home_screen.dart';
import 'package:authify_firebase/screens/signin_screen.dart';
import 'package:authify_firebase/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User? user;


  @override
  void initState() {
    user=FirebaseAuth.instance.currentUser;
    super.initState();
  } // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      // standard  dark theme
      themeMode: ThemeMode.system,
      // device controls theme
      initialRoute: user != null ? '/home_screen': '/',
      debugShowCheckedModeBanner: false,

      routes: {
        '/': (context) => SignInScreen(),
        '/signup_screen': (context) => SignUpScreen(),
        '/home_screen': (context) => HomeScreen(),
      },
    );
  }
}

