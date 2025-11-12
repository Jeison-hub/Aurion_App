import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'progress_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressController = Provider.of<ProgressController>(context);
    final lessons = progressController.progress.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        title: const Text('Historial de Aprendizaje'),
        backgroundColor: const Color(0xFF1A082E),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.white),
            onPressed: () {
              progressController.resetProgress();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Historial limpiado correctamente.',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Color(0xFF6A1B9A),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: lessons.length,
        itemBuilder: (context, index) {
          final key = lessons[index];
          final progress = progressController.progress[key] ?? 0.0;

          return ListTile(
            title: Text(
              key,
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              color: const Color(0xFFFFD700),
            ),
            trailing: Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
    );
  }
}
