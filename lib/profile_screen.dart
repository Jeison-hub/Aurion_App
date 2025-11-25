import 'package:aurion_app/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final progressController = Provider.of<ProgressController>(context);
    final totalProgress = progressController.totalProgress;
    final achievements = progressController.achievements;

    // 🔹 Rutas de imágenes de trofeos
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
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFFFFD700),
                    child: Text(
                      userName.isNotEmpty
                          ? userName[0].toUpperCase()
                          : userEmail[0].toUpperCase(),
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName.isNotEmpty ? userName : userEmail,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userEmail,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
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
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Sección de trofeos
            const Text(
              "Trofeos obtenidos",
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                      color: const Color(0xFF2E114D),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white24),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Center(
                      child: unlocked
                          ? Image.asset(
                        trophyImages[index],
                        width: 55,
                        height: 55,
                        fit: BoxFit.contain,
                      )
                          : Icon(
                        Icons.lock,
                        color: Colors.white24,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // 🔹 Botón de limpiar historial
            ElevatedButton(
              onPressed: () {
                progressController.resetProgress();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Historial limpiado. Todo el progreso ha sido reiniciado.',
                      style: TextStyle(color: Colors.white),
                    ),
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
