import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/services/user_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userService = UserService.instance;

  User? get curentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  UserModel? get userModel => _userService.getProfile();

  String get displayName => userModel?.displayName ?? 'Chronicler Member';

  String? get userEmail => userModel?.email;

  String? get photoURL => userModel?.photoURL;

  String get joinDate => userModel?.joinDate ?? '--';

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  Future<void> signOut() async {
    await _userService.signOut();
    await NotificationService.instance.clearAll();
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
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  Future<String?> updateDisplayName(String name) async {
    final error = await _userService.updateDisplayName(name);
    if (error == null) notifyListeners();
    return null;
  }

  Future<String?> updateEmail(String newEmail) async {
    final error = await _userService.updateEmail(newEmail);
    if (error == null) notifyListeners();
    return error;
  }

  Future<String?> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return await _userService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<String?> deleteAccount({required String password}) async {
    return await _userService.deleteAccount(password: password);
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
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'No internet connection. Try again.';
      case 'requires-recent-login':
        return 'Please sign in again before changing your password.';
      default:
        return 'Something went wrong. Try again.';
    }
  }
}
