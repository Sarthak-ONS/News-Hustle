import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newshustle/main.dart';

class VerifyEmail extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Timer timer;
  User user;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
      print(auth.currentUser.uid);
    });
    super.initState();
  }

  Future<void> checkEmailVerified() async {
    print("called");
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      print("Verified");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage(title: "News Hustle",)));
      timer.cancel();
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'An email is sent to ${auth.currentUser.displayName} for Verification. Please Verify your mail'),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
