import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'SignInPage.dart';
import 'VerificationPage.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          else if (snapshot.hasError) {
            return Center(child: Text("Error occurred: ${snapshot.error}"));
          }

          else {
            if (snapshot.data == null) {

              return const SignIn();
            } else {

              if (snapshot.data!.emailVerified) {

                return const HomePageView();
              } else {

                return const Verificationpage();
              }
            }
          }
        },
      ),
    );
  }
}
