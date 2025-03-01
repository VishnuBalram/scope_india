import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ColorPage.dart';
import 'SignInPage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error: $e');
      throw Exception('Error sending password reset email');
    }
  }


  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Error signing out');
    }
  }
}

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  String message = '';

  void _submit() async {
    String email = _emailController.text.trim();


    if (email.isEmpty || !email.contains('@')) {
      setState(() {
        message = 'Please enter a valid email address.';
      });
      return;
    }
    try {
      await auth.sendPasswordResetEmail(email);
      setState(() {
        message = 'Password reset instructions sent to $email';
      });
      Future.delayed(Duration(seconds: 2), () async {
        try {
          await auth.signOut();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        } catch (e) {
          print("Error signing out: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error logging out. Please try again.')),
          );
        }
      });
    } catch (e) {
      setState(() {
        message = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: backgdc,
        flexibleSpace: Container(
          height: 50,
          margin: const EdgeInsets.only(top: 25),
          child: const Image(
              image: AssetImage('Images/scope-india-logo-bird.png')),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('Images/reset_pass.png'),
              const SizedBox(height: 16),
              Text(
                'Enter your email address to reset your password',
                style: TextStyle(fontSize: 16, color: txtColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                style: const TextStyle(color: backgdc),
                cursorColor: backgdc,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: backgdc),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color:backgdc),
                  ),
                  labelStyle: const TextStyle(color: backgdc),
                  hintStyle: const TextStyle(color: backgdc),
                  floatingLabelStyle: const TextStyle(color: backgdc),
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              if (message.isNotEmpty)
                Text(
                  message,
                  style: TextStyle(color: message.contains('sent') ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
