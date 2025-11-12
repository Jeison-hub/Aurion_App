import 'package:flutter/material.dart';

class ModuleScreen extends StatelessWidget {
  final int moduleIndex;
  const ModuleScreen({super.key, required this.moduleIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        title: Text('Módulo $moduleIndex'),
        backgroundColor: const Color(0xFF3E1E68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF2A1740),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Contenido del Módulo $moduleIndex', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const Text('Aquí irá la descripción del curso, lecciones y recursos.', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF3E11E), foregroundColor: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Iniciar lección (placeholder)')));
              },
              child: const Text('Iniciar lección'),
            )
          ],
        ),
      ),
    );
  }
}
