import 'package:flutter/material.dart';

class ProgressController extends ChangeNotifier {
  final Map<String, double> _progress = {};

  Map<String, double> get progress => _progress;

  void completeLesson(String lessonTitle) {
    _progress[lessonTitle] = 1.0;
    notifyListeners();
  }

  void resetProgress() {
    _progress.clear();
    notifyListeners();
  }

  double getLessonProgress(String lessonTitle) {
    return _progress[lessonTitle] ?? 0.0;
  }
}
