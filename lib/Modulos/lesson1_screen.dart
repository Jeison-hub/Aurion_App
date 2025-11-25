import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson1Screen extends StatelessWidget {
  const Lesson1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 1: Phising',
      description:
      'Aprende cómo reconocer un ataque de pishing ya que es un ataque muy comun.',
      videoUrl: 'https://www.youtube.com/watch?v=UuuAlP7ay6U&t=3s',
      moduleKey: "modulo1",
    );
  }
}
