import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson2Screen extends StatelessWidget {
  const Lesson2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonTemplate(
      title: 'Módulo 2: Vishing',
      description:
      'El vishing utiliza llamadas telefónicas para engañar a las personas. Aprende a detectar este tipo de fraude.',
      videoUrl: 'https://www.youtube.com/watch?v=OJd1QqfDRJE',
    );
  }
}
