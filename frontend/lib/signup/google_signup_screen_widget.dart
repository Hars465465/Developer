import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_learn/login/login_screen.dart';

class signIn_screen_widget extends StatelessWidget {
  const signIn_screen_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: (){},
          child: Text.rich(
            TextSpan(
                text:"Already have an Account?",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  const WidgetSpan(
                    child: SizedBox(width: 5), // Add space here
                  ),
                  TextSpan(text: 'Login', style: const TextStyle(color: Colors.blueAccent,
                  ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                  ),
                ]
            ),
          ),
        ),
        const SizedBox(height: 10,),
        const Row(
          children: [
            Expanded(child: Divider(thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR", style: TextStyle(fontSize: 15)),
            ),
            Expanded(child: Divider(thickness: 1)),
          ],
        ),
        const SizedBox(height: 10,),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: Image.asset("assets/images/Google.png", width: 25,),
            onPressed: () async {
            },
            style: ElevatedButton.styleFrom(
              // Text Color
              backgroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 18, // Text size
                fontWeight: FontWeight.bold,
                // Text weight
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5), // Rounded corners
              ),
              elevation: 5,
              // Elevation
            ),
            label: const Text('Signup with google', style: TextStyle(color: Colors.black)),
          ),
        ),
      ],
    );

  }
}