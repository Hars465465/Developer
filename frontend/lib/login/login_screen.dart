import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_learn/login/login_screen_widget.dart';
import 'package:project_learn/login/login_google_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: const Column(
              children: [
                SizedBox(height: 50,),
                Center(child: Text("Welcome Back", style: TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold),)),
                LoginForm(),
                SignForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}