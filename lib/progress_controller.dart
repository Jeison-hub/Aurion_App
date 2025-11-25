import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProgressController extends ChangeNotifier {
  late Box _box;

  // Progreso: { "modulo1": 1.0, "modulo2": 0.5, ... }
  Map<String, double> _progress = {};

  // Trofeos desbloqueados
  List<bool> _achievements = List.generate(7, (_) => false);

  ProgressController() {
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('progressBox');
    _loadData();
  }

  void _loadData() {
    final savedProgress =
    Map<String, double>.from(_box.get('progress', defaultValue: {}));

    final savedAchievements = List<bool>.from(
      _box.get('achievements', defaultValue: List.generate(7, (_) => false)),
    );

    _progress = savedProgress;
    _achievements = savedAchievements;

    notifyListeners();
  }

  // GETTERS
  Map<String, double> get progress => _progress;
  List<bool> get achievements => _achievements;

  // Progreso total
  double get totalProgress {
    const totalModules = 7;

    double sum = 0.0;

    for (int i = 0; i < totalModules; i++) {
      final key = 'modulo${i + 1}';
      sum += _progress[key] ?? 0.0;
    }

    return sum / totalModules;
  }

  // Obtener progreso de un módulo por índice
  double getProgress(int index) {
    final key = 'modulo${index + 1}';
    return _progress[key] ?? 0.0;
  }

  // 🔥 Actualizar progreso usando moduleKey
  void updateProgress(String moduleKey, double value) {
    _progress[moduleKey] = value.clamp(0.0, 1.0);

    // Convertir moduleKey → index
    final index = int.parse(moduleKey.replaceAll("modulo", "")) - 1;

    if (index >= 0 && index < _achievements.length && value == 1.0) {
      _achievements[index] = true;
    }

    _saveData();
    notifyListeners();
  }

  void _saveData() {
    _box.put('progress', _progress);
    _box.put('achievements', _achievements);
  }

  // Resetear progreso
  void resetProgress() {
    _progress.clear();
    _achievements = List.generate(7, (_) => false);
    _saveData();
    notifyListeners();
  }
}
