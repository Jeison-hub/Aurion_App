import 'package:flutter/material.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A082E),
        title: const Text('Logros', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text('Aún no tienes logros. ¡Completa lecciones para obtenerlos!',
            style: TextStyle(color: Colors.white70)),
      ),
    );
  }
}
