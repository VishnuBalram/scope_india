import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scope_india/UI_page/wrapper.dart';

import 'ColorPage.dart';

class Verificationpage extends StatefulWidget {
  const Verificationpage({super.key});

  @override
  State<Verificationpage> createState() => _VerificationpageState();
}

class _VerificationpageState extends State<Verificationpage> {
  final auth = AuthService();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    auth.sendEmailVerificationLink();

    timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser?.emailVerified == true) {
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Wrapper())
        );
      }
    });
  }



  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgdc,
      appBar: AppBar(
          backgroundColor: backgdc,
          title: Text("Email Verification",style: TextStyle(color: Colors.white),),
      iconTheme:IconThemeData(color: Colors.white) ,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'A verification link has been sent to your email. Please check your inbox and verify your email.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.sendEmailVerificationLink();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Verification email resent')));
              },
              child: Text("Resend Email"),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text(
              "Please wait while we verify your email.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendEmailVerificationLink() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }


}
