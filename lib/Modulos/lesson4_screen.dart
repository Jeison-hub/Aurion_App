import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson4Screen extends StatelessWidget {
  const Lesson4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonTemplate(
      title: 'Módulo 4: Contraseñas seguras',
      description:
      'Aprende a crear contraseñas fuertes, únicas y difíciles de adivinar. No repitas contraseñas ni las compartas.',
      videoUrl: 'https://www.youtube.com/watch?v=HnPy6y7XiwY',
    );
  }
}
