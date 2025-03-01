import 'package:flutter/material.dart';
import 'ColorPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
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


      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
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
      backgroundColor: backgdc,
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('Images/forgot_password.png'),
              SizedBox(height: 16),
              Text(
                'Enter your email address to reset your password',
                style: TextStyle(fontSize: 16, color: txtColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              TextField(
                style: const TextStyle(color: txtColor),
                cursorColor: txtColor,
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bdrColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: bdrColor),
                  ),
                  labelStyle: TextStyle(color: txtColor),
                  hintStyle: TextStyle(color: txtColor),
                  floatingLabelStyle: TextStyle(color: txtColor),
                  hintText: 'Enter your email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
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

