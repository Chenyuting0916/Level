import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:level/services/user_service.dart';
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
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await currentUser!.linkWithCredential(credential);
      successMessage();
    } on FirebaseAuthException catch (e) {
      wrongMessage(e.code);
    }
  }

  void wrongMessage(String code) {
    var displayMessage = '';
    if (code == 'user-not-found') {
      displayMessage = 'InCorrectEmail'.i18n();
    } else if (code == 'wrong-password') {
      displayMessage = 'IncorrectPassword'.i18n();
    } else if (code == 'weak-password') {
      displayMessage = 'WeakPassword'.i18n();
    } else if (code == 'provider-already-linked') {
      displayMessage = 'ProviderAlreadyLinked'.i18n();
    } else {
      displayMessage = code;
    }
    Fluttertoast.showToast(
        msg: displayMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent.shade700,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  signoutAndLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await UserService().createUserIfNotExist();
    } on FirebaseAuthException catch (e) {
      wrongMessage(e.code);
    }
    successMessage();
  }

  void successMessage() {
    Fluttertoast.showToast(
        msg: 'Success'.i18n(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent.shade700,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}
