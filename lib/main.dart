import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart'; // 👈 Importa Hive
import 'progress_controller.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 👇 Inicializa Hive antes de correr la app
  await Hive.initFlutter();

  // 👇 Abre box para guardar progreso de usuario
  await Hive.openBox('progressBox');

  // 👇 Abre box para guardar información del usuario logueado
  await Hive.openBox('usersBox');   // 🔥 ESTA ES LA NUEVA LÍNEA

  // 👇 Corre la app con Provider
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
        scaffoldBackgroundColor: const Color(0xFF1A082E),
      ),
      home: const LoginScreen(),
    );
  }
}

