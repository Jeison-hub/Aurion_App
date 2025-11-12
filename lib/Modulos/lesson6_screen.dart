import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson6Screen extends StatelessWidget {
  const Lesson6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LessonTemplate(
      title: 'Módulo 6: Malware y virus',
      description:
      'Comprende cómo los virus y troyanos infectan los dispositivos y cómo protegerte usando software adecuado.',
      videoUrl: 'https://www.youtube.com/watch?v=O9b_rh1GXfk',
    );
  }
}
