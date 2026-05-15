import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressService {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // Obtener referencia usuario
  DocumentReference get userDoc {

    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection('users')
        .doc(uid);
  }

  //  Completar módulo
  Future<void> completeModule(
      String moduleId) async {

    await userDoc.update({

      'completedModules':
      FieldValue.arrayUnion([moduleId]),
    });
  }

  //  Obtener módulos completados
  Future<List<dynamic>> getCompletedModules() async {

    final snapshot = await userDoc.get();

    final data = snapshot.data() as Map<String, dynamic>;

    return data['completedModules'] ?? [];
  }

  //  Verificar módulo
  Future<bool> isModuleCompleted(
      String moduleId) async {

    final modules =
    await getCompletedModules();

    return modules.contains(moduleId);
  }
}