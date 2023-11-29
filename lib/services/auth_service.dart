import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:localization/localization.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? get currentUser => _auth.currentUser;

  Future<User?> getOrCreateUser() async {
    if (currentUser == null) {
      await _auth.signInAnonymously();
    }

    return currentUser;
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await account?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

    try {
      currentUser?.linkWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {}
    }
  }

  signInWithEmail(String email, String password) async {
    if (currentUser == null && currentUser!.isAnonymous) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser!.linkWithCredential(credential);
    } else {
      Fluttertoast.showToast(
          msg: "AlreadyLinked".i18n(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  login() {}
}
