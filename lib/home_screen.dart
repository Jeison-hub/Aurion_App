import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'history_screen.dart';
import 'achievements_screen.dart';

// Importamos las pantallas de los módulos
import 'modulos/lesson1_screen.dart';
import 'modulos/lesson2_screen.dart';
import 'modulos/lesson3_screen.dart';
import 'modulos/lesson4_screen.dart';
import 'modulos/lesson5_screen.dart';
import 'modulos/lesson6_screen.dart';
import 'modulos/lesson7_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> modulos = [
      {'titulo': 'Lección 1: Phishing', 'progreso': 0.0},
      {'titulo': 'Lección 2: Vishing', 'progreso': 0.0},
      {'titulo': 'Lección 3: Smishing', 'progreso': 0.0},
      {'titulo': 'Lección 4: Contraseñas seguras', 'progreso': 0.0},
      {'titulo': 'Lección 5: Navegación segura', 'progreso': 0.0},
      {'titulo': 'Lección 6: Seguridad en redes Wi-Fi', 'progreso': 0.0},
      {'titulo': 'Lección 7: Protección de datos personales', 'progreso': 0.0},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A082E),
        title: const Text(
          'Aurion',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          // Botón de logros
          IconButton(
            icon: const Icon(Icons.emoji_events, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AchievementsScreen()),
              );
            },
          ),
          // Botón de historial
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryScreen()),
              );
            },
          ),
          // Cerrar sesión
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Panel de perfil
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2E114D),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFFFFD700),
                      child: Text('A', style: TextStyle(color: Colors.black)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Bienvenido, Admin',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'admin@example.com',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 0.0,
                            color: Color(0xFFFFD700),
                            backgroundColor: Colors.white24,
                          ),
                          Text(
                            '0% completado',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Módulos de aprendizaje',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // 🔹 Módulos
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: modulos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Widget targetScreen;

                    // ✅ Selecciona la pantalla según el módulo
                    switch (index) {
                      case 0:
                        targetScreen = const Lesson1Screen();
                        break;
                      case 1:
                        targetScreen = const Lesson2Screen();
                        break;
                      case 2:
                        targetScreen = const Lesson3Screen();
                        break;
                      case 3:
                        targetScreen = const Lesson4Screen();
                        break;
                      case 4:
                        targetScreen = const Lesson5Screen();
                        break;
                      case 5:
                        targetScreen = const Lesson6Screen();
                        break;
                      case 6:
                        targetScreen = const Lesson7Screen();
                        break;
                      default:
                        targetScreen = const Lesson1Screen();
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => targetScreen),
                    );
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E114D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFFFD700),
                          radius: 14,
                          child: Text('${index + 1}',
                              style: const TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          modulos[index]['titulo'],
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const Spacer(),
                        LinearProgressIndicator(
                          value: modulos[index]['progreso'],
                          color: const Color(0xFFFFD700),
                          backgroundColor: Colors.white24,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '0% completado',
                          style: TextStyle(color: Colors.white54, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
