import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson3Screen extends StatelessWidget {
  const Lesson3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 3: Smishing',
      description:
      'El smishing usa mensajes SMS engañosos para robar información.',
      videoUrl: 'https://www.youtube.com/watch?v=t6k24MQFCsw',
      moduleKey: "modulo3",
    );
  }
}
