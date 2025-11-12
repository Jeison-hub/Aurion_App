import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson7Screen extends StatelessWidget {
  const Lesson7Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonTemplate(
      title: 'Módulo 7: Ciberseguridad avanzada',
      description:
      'Un repaso general sobre cómo mantenerte seguro en línea: autenticación de dos pasos, copias de seguridad y más.',
      videoUrl: 'https://www.youtube.com/watch?v=O6Ra6vGi3Lo',
    );
  }
}
