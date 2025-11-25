import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson5Screen extends StatelessWidget {
  const Lesson5Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 5: Navegación segura',
      description:
      'La navegacion segura es una de las mas importantes ya que te ayuda a mantenerte a salvo de posibles ataques',
      videoUrl: 'https://www.youtube.com/watch?v=cjSNVxtXY-U',
      moduleKey: "modulo5",
    );
  }
}
