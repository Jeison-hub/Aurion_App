import 'package:flutter/material.dart';

class ModuleDetailScreen extends StatefulWidget {
  final String titulo;
  final double progresoInicial;
  final Function(double) onComplete;

  const ModuleDetailScreen({
    super.key,
    required this.titulo,
    required this.progresoInicial,
    required this.onComplete,
  });

  @override
  State<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends State<ModuleDetailScreen> {
  double progreso = 0.0;
  bool completado = false;

  @override
  void initState() {
    super.initState();
    progreso = widget.progresoInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        title: Text(widget.titulo, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1A082E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contenido de la lección:',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: const Text(
                  'En esta lección aprenderás los conceptos básicos de seguridad digital, '
                      'como la importancia de usar contraseñas seguras, no compartir información '
                      'personal, identificar sitios web fraudulentos y mantener actualizado tu software.\n\n'
                      '1. Usa contraseñas con al menos 8 caracteres, letras mayúsculas, minúsculas y símbolos.\n'
                      '2. No compartas tus credenciales con nadie.\n'
                      '3. Asegúrate de verificar los dominios antes de ingresar datos sensibles.\n'
                      '4. Activa la autenticación en dos pasos cuando sea posible.\n'
                      '5. Evita redes Wi-Fi públicas para acceder a información importante.',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progreso,
              color: Colors.yellow,
              backgroundColor: Colors.white24,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: completado ? Colors.grey : Colors.white,
                foregroundColor: const Color(0xFF3E1E68),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: completado
                  ? null
                  : () {
                setState(() {
                  progreso = 1.0;
                  completado = true;
                });
                widget.onComplete(1.0);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '¡Lección completada! Has ganado un nuevo logro.',
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              child: Text(
                  completado ? 'Completado ✓' : 'Marcar como completado'),
            ),
          ],
        ),
      ),
    );
  }
}
