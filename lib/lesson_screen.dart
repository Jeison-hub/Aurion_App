import 'package:aurion_app/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  final String titulo;
  final double progreso;
  final int index;

  const LessonScreen({
    super.key,
    required this.titulo,
    required this.progreso,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final progressController = Provider.of<ProgressController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A082E),
        title: Text(titulo, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video o imagen representativa del módulo
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2E114D),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Contenido del módulo:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Aquí iría la explicación, video o recurso educativo del módulo.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // amarillo
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final key = 'modulo${index + 1}';
                final current = progressController.progress[key] ?? 0.0;

                if (current < 1.0) {
                  // updateProgress ya guarda en Hive y desbloquea el trofeo si value == 1.0
                  progressController.updateProgress(index, 1.0);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '¡Módulo completado! 🏆 Has ganado un trofeo.',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFF6A1B9A), // morado
                      duration: Duration(seconds: 3),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Este módulo ya está completado ✅',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color(0xFF6A1B9A),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Center(
                child: Text(
                  'Marcar como completado',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
