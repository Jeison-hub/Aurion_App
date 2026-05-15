import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register_screen.dart';
import 'home_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _loading = false;

  // LOGIN FIREBASE
  Future<void> _login() async {

    String email = _emailController.text.trim();

    String password = _passwordController.text.trim();

    //  Validar campos
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

    //  Validar longitud
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

      //  LOGIN CON FIREBASE
      UserCredential userCredential =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Verificar email
      if (user != null && !user.emailVerified) {

        await FirebaseAuth.instance.signOut();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Debes verificar tu correo antes de iniciar sesión 📧',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.orange,
          ),
        );

        return;
      }

      //  LOGIN EXITOSO
      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) => HomeScreen(

            userEmail: email,

            userName: email,

            isAdmin: false,
          ),
        ),
      );

    } on FirebaseAuthException catch (e) {

      String message = 'Error al iniciar sesión';

      if (e.code == 'user-not-found') {

        message = 'El usuario no existe.';

      } else if (e.code == 'wrong-password') {

        message = 'Contraseña incorrecta.';

      } else if (e.code == 'invalid-email') {

        message = 'Correo inválido.';

      } else if (e.code == 'invalid-credential') {

        message = 'Correo o contraseña incorrectos.';
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

  // RECUPERAR CONTRASEÑA
  void _recoverPassword() {

    Navigator.push(

      context,

      MaterialPageRoute(
        builder: (context) =>
        const ForgotPasswordScreen(),
      ),
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

            // LOGO
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
                  size: 80,
                  color: Colors.white54,
                );
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

            //  EMAIL
            TextField(

              controller: _emailController,

              style: const TextStyle(
                color: Colors.black,
              ),

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
            TextField(

              controller: _passwordController,

              obscureText: true,

              style: const TextStyle(
                color: Colors.black,
              ),

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

            // FORGOT PASSWORD
            Align(

              alignment: Alignment.centerRight,

              child: TextButton(

                onPressed: _recoverPassword,

                child: const Text(

                  '¿Olvidaste tu contraseña?',

                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BOTÓN LOGIN
            ElevatedButton(

              onPressed: _loading
                  ? null
                  : _login,

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

                'Ingresar',

                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // REGISTER
            TextButton(

              onPressed: () {

                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                    const RegisterScreen(),
                  ),
                );
              },

              child: const Text(

                '¿No tienes cuenta? Regístrate',

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
