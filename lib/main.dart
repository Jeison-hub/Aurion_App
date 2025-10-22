import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const AurionApp());
}

class AurionApp extends StatelessWidget {
  const AurionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aurion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3E1E68)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
