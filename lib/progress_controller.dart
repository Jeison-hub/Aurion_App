import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressController extends ChangeNotifier {

  Map<String, double> _progress = {};

  List<bool> _achievements =
  List.generate(7, (_) => false);

  // GETTERS
  Map<String, double> get progress =>
      _progress;

  List<bool> get achievements =>
      _achievements;

  ProgressController() {

    loadUserProgress();
  }

  // =====================================================
  // 🔥 CARGAR PROGRESO DEL USUARIO ACTUAL
  // =====================================================

  Future<void> loadUserProgress() async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final doc = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(user.uid)
        .get();

    // 🔥 SI NO EXISTE DOCUMENTO
    if (!doc.exists) {

      _progress = {};

      _achievements =
          List.generate(7, (_) => false);

      notifyListeners();

      return;
    }

    final data = doc.data();

    // 🔥 PROGRESO
    if (data?['progress'] != null) {

      final rawProgress =
      Map<String, dynamic>.from(
        data!['progress'],
      );

      _progress = rawProgress.map(
            (key, value) => MapEntry(
          key,
          (value as num).toDouble(),
        ),
      );
    }

    // 🔥 ACHIEVEMENTS
    if (data?['achievements'] != null) {

      _achievements =
      List<bool>.from(
        data!['achievements'],
      );
    }

    notifyListeners();
  }

  // =====================================================
  // 🔥 TOTAL PROGRESS
  // =====================================================

  double get totalProgress {

    const totalModules = 7;

    double sum = 0.0;

    for (int i = 0; i < totalModules; i++) {

      final key = 'modulo${i + 1}';

      sum += _progress[key] ?? 0.0;
    }

    return sum / totalModules;
  }

  // =====================================================
  // 🔥 OBTENER PROGRESO
  // =====================================================

  double getProgress(int index) {

    final key = 'modulo${index + 1}';

    return _progress[key] ?? 0.0;
  }

  // =====================================================
  // 🔥 ACTUALIZAR PROGRESO
  // =====================================================

  Future<void> updateProgress(
      String moduleKey,
      double value,
      ) async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    _progress[moduleKey] =
        value.clamp(0.0, 1.0);

    final index = int.parse(
      moduleKey.replaceAll("modulo", ""),
    ) - 1;

    if (index >= 0 &&
        index < _achievements.length &&
        value == 1.0) {

      _achievements[index] = true;
    }

    // 🔥 GUARDAR EN FIRESTORE
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({

      'progress': _progress,

      'achievements': _achievements,

    }, SetOptions(merge: true));

    notifyListeners();
  }

  // =====================================================
  // 🔥 RESET PROGRESS
  // =====================================================

  Future<void> resetProgress() async {

    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) return;

    _progress.clear();

    _achievements =
        List.generate(7, (_) => false);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set({

      'progress': {},

      'achievements': _achievements,

    }, SetOptions(merge: true));

    notifyListeners();
  }
}