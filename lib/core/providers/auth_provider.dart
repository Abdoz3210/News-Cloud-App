import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/services/user_service.dart';
import 'package:news_app/core/services/realtime_database_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userService = UserService.instance;
  final _dbService = RealtimeDatabaseService.instance;

  String? _photoBase64;
  User? get curentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  String? get photoBase64 => _photoBase64;
  StreamSubscription? _photoSubscription;
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
    await _photoSubscription?.cancel();
    _photoSubscription = null;
    await _userService.signOut();
    _photoBase64 = null;
    // await NotificationService.instance.clearAll();
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
    final uid = _auth.currentUser?.uid;
    final error = await _userService.deleteAccount(password: password);

    if (error != null) return error;
    if (uid != null) {
      await _dbService.deleteUserData(uid);
    }
    return null;
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

  Future<void> loadUserPhoto() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;
    // await Future.delayed(const Duration(milliseconds: 500));
    // _photoBase64 = await _dbService.getUserPhoto(uid);
    await _photoSubscription?.cancel();
    _photoSubscription = _dbService.watchUserPhoto(uid).listen((base64) {
      _photoBase64 = base64;
      notifyListeners();
    });
    // print('loaded photo: ${_photoBase64 != null}');
    // notifyListeners();
  }

  Future<String?> uploadAndUpdatePhoto() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return 'Not signed in.';

    final file = await _dbService.pickImageFromGallery();
    if (file == null) return null;

    final error = await _dbService.saveUserPhoto(userId: uid, file: file);
    if (error != null) return error;

    final bytes = await file.readAsBytes();
    _photoBase64 = base64Encode(bytes);
    // _photoBase64 = await _dbService.getUserPhoto(uid);
    notifyListeners();

    return null;
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
