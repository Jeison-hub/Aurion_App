import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson2Screen extends StatelessWidget {
  const Lesson2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 2: Vishing',
      description:
      'El vishing utiliza llamadas telefónicas para engañar a las personas.',
      videoUrl: 'https://www.youtube.com/watch?v=sc9wmjR3l6g',
      moduleKey: "modulo2",
    );
  }
}
