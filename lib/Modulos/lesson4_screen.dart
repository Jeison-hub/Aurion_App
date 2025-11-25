import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson4Screen extends StatelessWidget {
  const Lesson4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 4: contraseñas seguras',
      description:
      'Aprende a usar contraseñas seguras para proteger tus datos.',
      videoUrl: 'https://www.youtube.com/watch?v=pS6sf2BwmWY',
      moduleKey: "modulo4",
    );
  }
}
