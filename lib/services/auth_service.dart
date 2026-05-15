import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  //  REGISTRO
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {

    UserCredential credential =
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Crear documento del usuario
    await _firestore
        .collection('users')
        .doc(credential.user!.uid)
        .set({

      'email': email,

      'createdAt': FieldValue.serverTimestamp(),

      'completedModules': [],

      'achievements': [],

      'history': [],
    });

    return credential;
  }

  // LOGIN
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {

    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //  LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  //  RESET PASSWORD
  Future<void> resetPassword(String email) async {

    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  // SESIÓN ACTUAL
  User? get currentUser => _auth.currentUser;
}