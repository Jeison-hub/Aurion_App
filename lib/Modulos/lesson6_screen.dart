import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson6Screen extends StatelessWidget {
  const Lesson6Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 6: Seguridad en redes Wi-Fi',
      description:
      'Descubre cómo la seguridad de tu internet es de vital importancia.',
      videoUrl: 'https://www.youtube.com/watch?v=2xdUcmMiK10',
      moduleKey: "modulo6",
    );
  }
}
