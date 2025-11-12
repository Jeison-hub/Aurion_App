import 'package:aurion_app/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressController = Provider.of<ProgressController>(context);
    final totalProgress = progressController.totalProgress;
    final achievements = progressController.achievements;

    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A082E),
        title: const Text('Perfil', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Información del usuario
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2E114D),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFFFD700),
                    child: Text('A', style: TextStyle(color: Colors.black, fontSize: 24)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Admin',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'admin@example.com',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: totalProgress,
                          backgroundColor: Colors.white24,
                          color: const Color(0xFFFFD700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(totalProgress * 100).toStringAsFixed(0)}% completado',
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 🔹 Sección de trofeos
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Trofeos obtenidos 🏆',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                itemCount: achievements.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final unlocked = achievements[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: unlocked ? const Color(0xFFFFD700) : Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: Center(
                      child: Icon(
                        unlocked ? Icons.emoji_events : Icons.lock,
                        color: unlocked ? Colors.black : Colors.white38,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔹 Botón de limpiar historial
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Restablecer progreso y trofeos
                for (int i = 0; i < achievements.length; i++) {
                  progressController.updateProgress(i, 0.0);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Historial limpiado. Todo el progreso ha sido reiniciado.'),
                    backgroundColor: Color(0xFF6A1B9A),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellowAccent,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Limpiar historial'),
            ),
          ],
        ),
      ),
    );
  }
}
