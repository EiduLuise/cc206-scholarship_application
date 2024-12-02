import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserDatabase {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up using Firebase Authentication
  Future<String?> signup ({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), 
        password: password.trim()
      );

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'name': name.trim(),
        'email': email.trim(),
        'number': phone.trim(),
      });
    }
    catch (e) {
      return e.toString();
    }
    return null;
  }

  //Log in using Firebase Authentication
  Future<String?> login({
    required String email, 
    required String password
    }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return email;
    } on FirebaseAuthException catch (e) {
      return e.toString(); 
    }
  }
}