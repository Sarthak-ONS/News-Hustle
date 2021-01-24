import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  handleAuthState() {
    return StreamBuilder(
      initialData: Text('Streamrunning'),
      stream: _firebaseAuth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
          return Text('Authenticated');
        } else
          return Text('Not Authenticated');
      },
    );
  }

  Future<void> sendemailVerification() async {
    await _firebaseAuth.currentUser.sendEmailVerification();
  }

  Future<String> createUserwithEmailandPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await currentUser.user.sendEmailVerification();

    await currentUser.user
        .updateProfile(displayName: name)
        .then((value) => print("Success"))
        .catchError((e) {
      print(e);
    });
    return currentUser.user.uid;
  }

  Future<String> signinUserwithEmailandPassword(
      String email, String password) async {
    final currentUser = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    if (_firebaseAuth.currentUser.emailVerified) {
      return currentUser.user.uid;
    } else {
      return null;
    }
  }

  Future<List> getprofile() async {
    return [
      _firebaseAuth.currentUser.displayName,
      _firebaseAuth.currentUser.email,
      _firebaseAuth.currentUser.photoURL
    ];
  }

  Future<String> signinwithEmailPassword(String email, String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user.user.uid;
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
