import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../progress_controller.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressController = Provider.of<ProgressController>(context);
    final achievements = progressController.achievements;

    // Rutas de imágenes de trofeos
    final trophyImages = [
      'assets/trofeos/trofeo1.png',
      'assets/trofeos/trofeo2.png',
      'assets/trofeos/trofeo3.png',
      'assets/trofeos/trofeo4.png',
      'assets/trofeos/trofeo5.png',
      'assets/trofeos/trofeo6.png',
      'assets/trofeos/trofeo7.png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A082E),
        title: const Text('Logros', style: TextStyle(color: Colors.white)),
      ),

      body: achievements.contains(true)
          ? ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          if (!achievements[index]) return const SizedBox.shrink();

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E114D),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white24),
            ),
            child: ListTile(
              leading: Image.asset(
                trophyImages[index],
                width: 50,
                height: 50,
              ),
              title: Text(
                "¡Felicidades! Completaste el Módulo ${index + 1}",
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Has ganado este trofeo 🎉",
                style: const TextStyle(color: Colors.white54),
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text(
          'Aún no tienes logros. ¡Completa lecciones para obtenerlos!',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
