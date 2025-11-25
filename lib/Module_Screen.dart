import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'progress_controller.dart';
import 'module_detail_screen.dart';

class ModuleScreen extends StatefulWidget {
  final int moduleIndex;
  const ModuleScreen({super.key, required this.moduleIndex});

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Forzar reconstrucción al volver del Navigator.pop()
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressController>(
      builder: (context, progressController, child) {
        final String moduleKey = 'modulo${widget.moduleIndex + 1}';
        final double progreso = progressController.progress[moduleKey] ?? 0.0;

        return Scaffold(
          backgroundColor: const Color(0xFF1A082E),
          appBar: AppBar(
            title: Text('Módulo ${widget.moduleIndex + 1}'),
            backgroundColor: const Color(0xFF3E1E68),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  color: const Color(0xFF2A1740),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Contenido del Módulo ${widget.moduleIndex + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Aquí irá la descripción del curso, lecciones y recursos.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Barra de progreso del módulo
                LinearProgressIndicator(
                  value: progreso,
                  backgroundColor: Colors.white24,
                  color: Colors.yellow,
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3E11E),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModuleDetailScreen(
                          titulo: "Módulo ${widget.moduleIndex + 1}",
                          progresoInicial: progreso,
                          onComplete: (double value) {
                            progressController.updateProgress(
                                widget.moduleIndex as String, value);
                          },
                        ),
                      ),
                    ).then((_) {
                      // 🔥 Actualizar progreso al volver
                      setState(() {});
                    });
                  },
                  child: const Text('Iniciar lección'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
