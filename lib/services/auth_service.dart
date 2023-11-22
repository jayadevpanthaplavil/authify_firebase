import 'package:authify_firebase/config/app_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User? user = authResult.user;

    return user;
  }

  Future<User?> signInWithFacebook() async {
    // Trigger Facebook login
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Check if login was successful
    //  if (loginResult.status == LoginStatus.success) {
    // Obtain access token
    final AccessToken accessToken = loginResult.accessToken!;

    // Use Facebook access token to authenticate with Firebase
    final AuthCredential credential =
        FacebookAuthProvider.credential(accessToken.token);

    // Sign in with Firebase
    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = authResult.user;
    return user;
    //     } else {
    //       // Handle login error
    //       print('Facebook login failed');
    //     }
    // }
  }

  Future<User?> signInWithGithub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: AppConfig.githubClientId,
        clientSecret: AppConfig.githubClientSecret,
        redirectUrl:AppConfig.githubRedirectUrl);
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token);
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        break;
    }

    final AuthCredential credential =
        GithubAuthProvider.credential(result.token as String);

    final UserCredential authResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? user = authResult.user;
    return user;
  }
}
