import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson1Screen extends StatelessWidget {
  const Lesson1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonTemplate(
      title: 'Módulo 1: Phishing',
      description:
      'Aprende qué es el phishing, cómo identificar correos falsos y cómo protegerte de fraudes digitales.',
      videoUrl: 'https://www.youtube.com/watch?v=8PjZ8I4CZvw',
    );
  }
}
