import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A082E),
        elevation: 0,
        title: const Text(
          'Recuperar contraseña',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),

            // 🔹 Logo Aurion
            Image.asset(
              'assets/logo.png',
              height: 120,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.lock_outline,
                color: Colors.white54,
                size: 80,
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Ingresa tu correo electrónico registrado y te enviaremos un enlace para restablecer tu contraseña.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Correo electrónico',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () {
                if (_emailController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor ingresa tu correo electrónico.'),
                      backgroundColor: Color(0xFF6A1B9A),
                    ),
                  );
                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Correo de recuperación enviado 📧',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Color(0xFF6A1B9A),
                  ),
                );

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Enviar enlace de recuperación',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
