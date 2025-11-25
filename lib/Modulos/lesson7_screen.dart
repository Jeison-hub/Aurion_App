import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson7Screen extends StatelessWidget {
  const Lesson7Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 7: Proteccion de datos personales.',
      description:
      'Aprende cómo crear contraseñas robustas y proteger tus cuentas.',
      videoUrl: 'https://www.youtube.com/watch?v=gSmHy5wE-dU',
      moduleKey: "modulo7",
    );
  }
}
