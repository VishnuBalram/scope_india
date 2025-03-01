import 'package:flutter/material.dart';
import 'package:scope_india/UI_page/ColorPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomePage.dart';
import 'forgotPassword.dart';
import 'RegisterPage.dart';

bool PasswordVisible = false;
final auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('StudentDetails');
late String emailId, passwordId;

Future<bool> validateUserCredentials(String email, String password) async {
  try {
    // Query Firestore for user with the given email
    QuerySnapshot snapshot = await users.where('email', isEqualTo: email).get();

    if (snapshot.docs.isEmpty) {
      // No user found with the given email
      return false;
    }

    // If user found, compare the password with the stored one
    var userDoc = snapshot.docs.first;
    String storedPassword = userDoc['password'];

    // Check if the password entered matches the one stored in Firestore
    if (storedPassword == password) {
      return true;
    } else {
      return false; // Password does not match
    }
  } catch (e) {
    print("Error checking credentials: $e");
    return false;
  }
}

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgdc,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            Center(
              child: Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('Images/name.jpeg'))
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Email TextField
            Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: typBoxcolor,
                ),
                child: TextField(
                  onChanged: (e) {
                    emailId = e;
                  },
                  decoration: InputDecoration(
                    fillColor: typBoxcolor,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.1, color: typBoxcolor),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 0.1, color: typBoxcolor),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    labelText: "Email",
                    labelStyle: const TextStyle(color: txtColor),
                    hintText: "abc123@gmail.com",
                    prefixIcon: const Icon(Icons.mail, color: Colors.blueAccent),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password TextField
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: typBoxcolor,
              ),
              width: 300,
              child: TextField(
                obscureText: !PasswordVisible,
                onChanged: (e) {
                  passwordId = e;
                },
                decoration: InputDecoration(
                  fillColor: typBoxcolor,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.1, color: typBoxcolor),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0.1, color: typBoxcolor),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  labelText: "Password",
                  labelStyle: const TextStyle(color: txtColor),
                  hintText: "123abc@#",
                  prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                  suffixIcon: IconButton(
                    icon: PasswordVisible
                        ? const Icon(Icons.visibility, color: backgdc)
                        : Icon(Icons.visibility_off, color: fillColor),
                    onPressed: () {
                      setState(() {
                        PasswordVisible = !PasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            // Forgot Password link
            Container(
              height: 40,
              width: 200,
              margin: const EdgeInsets.only(left: 150),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPass()));
                },
                child: const Text('Forgot Password?', style: TextStyle(color: txtColor)),
              ),
            ),
            // Log In button
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                  setState(() {
                    isLoading = true;
                  });

                  try {
                    // First, authenticate with Firebase using the provided credentials
                    UserCredential userCredential = await auth.signInWithEmailAndPassword(
                      email: emailId,
                      password: passwordId,
                    );

                    // After successful Firebase authentication, check Firestore for valid credentials
                    bool isValid = await validateUserCredentials(emailId, passwordId);

                    if (isValid) {
                      // If credentials are valid, navigate to HomePage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) => const HomePageView()),
                      );
                    } else {
                      // If credentials are invalid in Firestore
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Invalid details or login failed'),
                          backgroundColor: errorColor,
                          margin: EdgeInsets.only(bottom: 500, left: 50, right: 50),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } catch (e) {
                    // Handle any errors related to Firebase sign-in
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error Invalid details '),
                        backgroundColor: errorColor,
                        margin: EdgeInsets.only(bottom: 500, left: 50, right: 50),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(txtColor),
                )
                    : const Text('Log In'),
              ),
            ),
            // Sign up link
            Container(
              margin: const EdgeInsets.only(left: 70),
              child: Row(
                children: [
                  const Text('Do you have an account?', style: TextStyle(color: txtColor)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
                    },
                    child: const Text('SIGN UP', style: TextStyle(fontSize: 15, color: txtColor)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
