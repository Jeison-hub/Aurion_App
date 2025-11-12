import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'forgot_password_screen.dart'; // 🔹 Agrega esto

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor completa todos los campos.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF6A1B9A),
        ),
      );
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'La contraseña debe tener al menos 8 caracteres.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF6A1B9A),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  // 🔹 Aquí reemplazamos la función por la navegación correcta
  void _recoverPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            // 🔹 Imagen del logo (asegúrate que exista en assets/logo.png)
            Image.asset(
              'assets/logo.png',
              height: 140,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.image_not_supported,
                    size: 80, color: Colors.white54);
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Iniciar sesión',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Contraseña',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _recoverPassword, // 🔹 Ahora abre la pantalla correcta
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding:
                const EdgeInsets.symmetric(horizontal: 100, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Ingresar',
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text(
                '¿No tienes cuenta? Regístrate',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
