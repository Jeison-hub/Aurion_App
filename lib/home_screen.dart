import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_screen.dart';
import 'login_screen.dart';
import 'history_screen.dart';
import 'achievements_screen.dart';

import 'progress_controller.dart';

// Pantallas de los módulos
import 'modulos/lesson1_screen.dart';
import 'modulos/lesson2_screen.dart';
import 'modulos/lesson3_screen.dart';
import 'modulos/lesson4_screen.dart';
import 'modulos/lesson5_screen.dart';
import 'modulos/lesson6_screen.dart';
import 'modulos/lesson7_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userEmail;
  final String userName;
  final bool isAdmin;

  const HomeScreen({
    super.key,
    required this.userEmail,
    required this.userName,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressController>(
      builder: (context, progressController, child) {
        // 🔥 Progreso total REAL
        final double total = progressController.totalProgress;

        final List<Map<String, dynamic>> modulos = [
          {'titulo': 'Lección 1: Phishing'},
          {'titulo': 'Lección 2: Vishing'},
          {'titulo': 'Lección 3: Smishing'},
          {'titulo': 'Lección 4: Contraseñas seguras'},
          {'titulo': 'Lección 5: Navegación segura'},
          {'titulo': 'Lección 6: Seguridad en redes Wi-Fi'},
          {'titulo': 'Lección 7: Protección de datos personales'},
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
              IconButton(
                icon: const Icon(Icons.emoji_events, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AchievementsScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.history, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen()),
                  );
                },
              ),
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
                // ───────────────────────────────────────────────
                // TARJETA DE USUARIO
                // ───────────────────────────────────────────────
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          userName: userName,
                          userEmail: userEmail,
                        ),
                      ),
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
                        CircleAvatar(
                          backgroundColor: const Color(0xFFFFD700),
                          child: Text(
                            userName.isNotEmpty
                                ? userName[0].toUpperCase()
                                : userEmail[0].toUpperCase(),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bienvenido, ${userName.isNotEmpty ? userName : userEmail}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userEmail,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // 🔥 Barra de progreso REAL
                              LinearProgressIndicator(
                                value: total,
                                color: const Color(0xFFFFD700),
                                backgroundColor: Colors.white24,
                              ),
                              Text(
                                '${(total * 100).round()}% completado',
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
                ),

                const SizedBox(height: 20),
                const Text(
                  'Módulos de aprendizaje',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // ───────────────────────────────────────────────
                // GRID DE MÓDULOS
                // ───────────────────────────────────────────────
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
                    // 🔥 Progreso REAL por módulo
                    final String key = "modulo${index + 1}";
                    final double progreso = progressController.progress[key] ?? 0.0;

                    return GestureDetector(
                      onTap: () {
                        late final Widget targetScreen;

                        switch (index) {
                          case 0: targetScreen = const Lesson1Screen() as Widget; break;
                          case 1: targetScreen = const Lesson2Screen(); break;
                          case 2: targetScreen = const Lesson3Screen(); break;
                          case 3: targetScreen = const Lesson4Screen(); break;
                          case 4: targetScreen = const Lesson5Screen(); break;
                          case 5: targetScreen = const Lesson6Screen(); break;
                          case 6: targetScreen = const Lesson7Screen(); break;
                          default: targetScreen = const Lesson1Screen() as Widget;
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
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 8),

                            Text(
                              modulos[index]['titulo'],
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),

                            const Spacer(),

                            LinearProgressIndicator(
                              value: progreso,
                              color: const Color(0xFFFFD700),
                              backgroundColor: Colors.white24,
                            ),

                            const SizedBox(height: 4),
                            Text(
                              '${(progreso * 100).round()}% completado',
                              style: const TextStyle(color: Colors.white54, fontSize: 11),
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
      },
    );
  }
}
