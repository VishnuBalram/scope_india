import 'package:flutter/material.dart';
import 'package:scope_india/UI_page/ColorPage.dart';
import 'package:scope_india/UI_page/wrapper.dart';

class AniScreen extends StatefulWidget {
  const AniScreen({super.key});

  @override
  State<AniScreen> createState() => _AniScreenState();
}

class _AniScreenState extends State<AniScreen> {
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Wrapper()),
      );
    });

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _scale = 0.8;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgdc,
      body: Center(
        child: AnimatedScale(
          scale: _scale,
          duration: Duration(seconds: 3),
          curve: Curves.easeOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.asset("Images/scope-india-logo-bird.png"),
              ),
              SizedBox(height: 15),
              Text(
                'Scope India',
                style: TextStyle(
                  fontSize: 45,
                  color: txtColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
