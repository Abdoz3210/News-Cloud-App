import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/services/secure_storage_secvice.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _secureStorage = SecureStorageSecvice.instance;
  User? get curentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _secureStorage.saveUserEmail(email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _secureStorage.clearAll();
    notifyListeners();
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user?.updateDisplayName(username);
      await _secureStorage.saveUserEmail(email);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  Future<String?> getToken() async {
    try {
      return await _auth.currentUser?.getIdToken(true);
    } catch (e) {
      return null;
    }
  }

  Future<void> handleTokenExpiry() async {
    final token = await getToken();
    if (token == null) {
      await signOut();
    }
  }

  String _mapError(String code) {
    switch (code) {
      case 'user_notfound':
        return 'No accouunt Found with this email.';
      case 'worng-password':
        return 'Incorrect password, Try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'No internet connection. Try again.';
      default:
        return ' Something went wrong, Try agfin later.....';
    }
  }
}
