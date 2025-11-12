import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson3Screen extends StatelessWidget {
  const Lesson3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonTemplate(
      title: 'Módulo 3: Smishing',
      description:
      'Descubre cómo los ciberdelincuentes usan mensajes SMS falsos con enlaces maliciosos para robar datos.',
      videoUrl: 'https://www.youtube.com/watch?v=aCuvVv4Kqiw',
    );
  }
}
