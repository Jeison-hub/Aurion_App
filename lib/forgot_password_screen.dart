import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final TextEditingController _emailController =
  TextEditingController();

  bool _loading = false;

  //  Validar email
  bool _isValidEmail(String email) {

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    return emailRegex.hasMatch(email);
  }

  // RECUPERAR CONTRASEÑA
  Future<void> _resetPassword() async {

    final email = _emailController.text.trim();

    // Campo vacío
    if (email.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor ingresa tu correo electrónico.',
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
            'Ingresa un correo válido.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    try {

      setState(() {
        _loading = true;
      });

      //  FIREBASE RESET PASSWORD
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Correo de recuperación enviado 📧',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );

      //  REGRESAR AL LOGIN
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {

      String message = 'Ocurrió un error';

      if (e.code == 'user-not-found') {

        message = 'No existe una cuenta con este correo.';

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

            //  LOGO
            Image.asset(

              'assets/logo.png',

              height: 120,

              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {

                return const Icon(
                  Icons.lock_outline,
                  color: Colors.white54,
                  size: 80,
                );
              },
            ),

            const SizedBox(height: 40),

            const Text(

              'Ingresa tu correo electrónico registrado y te enviaremos un enlace para restablecer tu contraseña.',

              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

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

            const SizedBox(height: 25),

            //  BOTÓN
            ElevatedButton(

              onPressed: _loading
                  ? null
                  : _resetPassword,

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.amber,

                foregroundColor: Colors.black,

                minimumSize:
                const Size(double.infinity, 50),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              child: _loading
                  ? const CircularProgressIndicator(
                color: Colors.black,
              )
                  : const Text(

                'Enviar enlace de recuperación',

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}