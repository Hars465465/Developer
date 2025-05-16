import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_learn/signup/google_signup_screen_widget.dart';
import 'package:project_learn/signup/signup_screen.dart';
import 'package:project_learn/signup/signup_screen_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Center(child: Text("Create Account!", style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold),)),
                SignUp_screen_widget(),
                const signIn_screen_widget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






