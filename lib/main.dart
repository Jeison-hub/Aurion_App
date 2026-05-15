import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'progress_controller.dart';
import 'login_screen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(

    ChangeNotifierProvider(

      create: (_) => ProgressController(),

      child: const AurionApp(),
    ),
  );
}

class AurionApp extends StatelessWidget {

  const AurionApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Aurion',

      theme: ThemeData(

        brightness: Brightness.dark,

        scaffoldBackgroundColor:
        const Color(0xFF1A082E),
      ),

      home: const LoginScreen(),
    );
  }
}