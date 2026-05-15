import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _generatedPassword = '';

  bool _showGeneratedPassword = false;

  bool _loading = false;

  //  Generador de contraseña segura
  String _generateSecurePassword() {

    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()-_=+';

    final random = Random();

    return List.generate(
      12,
          (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  //  Validar email
  bool _isValidEmail(String email) {

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    return emailRegex.hasMatch(email);
  }

  // REGISTRO FIREBASE
  Future<void> _register() async {

    final email = _emailController.text.trim();

    final password = _passwordController.text.trim();

    //  Validar campos vacíos
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

    //  Validar email
    if (!_isValidEmail(email)) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor ingresa un correo válido.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF6A1B9A),
        ),
      );

      return;
    }

    //  Validar contraseña
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

    try {

      setState(() {
        _loading = true;
      });

      // REGISTRO EN FIREBASE
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Enviar verificación de correo
      await FirebaseAuth.instance.currentUser!
          .sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '¡Registro exitoso! Verifica tu correo',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message = 'Ocurrió un error';

      if (e.code == 'email-already-in-use') {

        message = 'Este correo ya está registrado.';

      } else if (e.code == 'weak-password') {

        message = 'La contraseña es demasiado débil.';

      } else if (e.code == 'invalid-email') {

        message = 'Correo inválido.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );

    } finally {

      setState(() {
        _loading = false;
      });
    }
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

            const SizedBox(height: 60),

            Image.asset(
              'assets/logo.png',
              height: 140,

              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {

                return const Icon(
                  Icons.image_not_supported,
                  color: Colors.white54,
                  size: 80,
                );
              },
            ),

            const SizedBox(height: 30),

            const Text(
              'Crear cuenta',

              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // EMAIL
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

            // PASSWORD
            Focus(

              onFocusChange: (hasFocus) {

                if (hasFocus) {

                  setState(() {

                    _generatedPassword =
                        _generateSecurePassword();

                    _showGeneratedPassword = true;
                  });
                }
              },

              child: TextField(

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
            ),

            const SizedBox(height: 8),

            // PASSWORD SUGERIDA
            if (_showGeneratedPassword)

              Container(

                margin: const EdgeInsets.only(top: 8),

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(

                  color: const Color(0xFF2E114D),

                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(

                  children: [

                    const Text(
                      'Sugerencia de contraseña segura:',

                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 6),

                    SelectableText(

                      _generatedPassword,

                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),

                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    ElevatedButton.icon(

                      onPressed: () {

                        _passwordController.text =
                            _generatedPassword;

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Contraseña copiada al campo',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            backgroundColor:
                            Color(0xFF6A1B9A),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },

                      icon: const Icon(
                        Icons.copy,
                        color: Colors.black,
                      ),

                      label: const Text(
                        'Usar esta contraseña',

                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            //  BOTÓN REGISTRO
            ElevatedButton(

              onPressed: _loading
                  ? null
                  : _register,

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.amber,

                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 14,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              child: _loading
                  ? const CircularProgressIndicator(
                color: Colors.black,
              )
                  : const Text(
                'Registrarse',

                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(

              onPressed: () {

                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                    const LoginScreen(),
                  ),
                );
              },

              child: const Text(
                '¿Ya tienes cuenta? Inicia sesión',

                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

