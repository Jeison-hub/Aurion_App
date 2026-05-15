import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';
import 'home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<User?>(

      stream:
      FirebaseAuth.instance.authStateChanges(),

      builder: (context, snapshot) {

        //  Cargando
        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        //  Usuario logueado
        if (snapshot.hasData) {

          final user = snapshot.data!;

          return HomeScreen(
            userEmail: user.email ?? '',
            userName: user.email ?? '',
            isAdmin: false,
          );
        }

        //  Usuario NO logueado
        return const LoginScreen();
      },
    );
  }
}