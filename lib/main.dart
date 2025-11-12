import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart'; // 👈 Importa Hive
import 'progress_controller.dart';
import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 👇 Inicializa Hive antes de correr la app
  await Hive.initFlutter();

  // 👇 Abre una box para guardar el progreso de los usuarios
  await Hive.openBox('progressBox');

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
