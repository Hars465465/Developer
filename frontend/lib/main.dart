import 'package:flutter/material.dart';
import 'package:project_learn/home_screen.dart';
import 'package:project_learn/login/login_screen.dart';
import 'package:project_learn/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Project',
      // Dark theme
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
          background: const Color(0xFF202C35) // Explicitly set dark mode
        ),
        useMaterial3: true,
      ),
      // Force dark mode
      themeMode: ThemeMode.dark,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}