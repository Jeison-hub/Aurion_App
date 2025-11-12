import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson5Screen extends StatelessWidget {
  const Lesson5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonTemplate(
      title: 'Módulo 5: Seguridad en redes sociales',
      description:
      'Aprende a configurar tu privacidad, detectar suplantaciones y mantener tu información segura en redes sociales.',
      videoUrl: 'https://www.youtube.com/watch?v=tmzH2TPyqvE',
    );
  }
}
