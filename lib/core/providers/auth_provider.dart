import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/services/notification_service.dart';
import 'package:news_app/core/services/secure_storage_secvice.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/services/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _secureStorage = SecureStorageSecvice.instance;
  final _storageService = StorageService.instance;

  User? get curentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;

  String get displayName =>
      _auth.currentUser?.displayName ?? 'Chronicler Member';

  String? get userEmail => _auth.currentUser?.email;

  String? get photoURL => _auth.currentUser?.photoURL;

  String get joinDate {
    final date = _auth.currentUser?.metadata.creationTime;
    if (date == null) return '-';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  Future<String?> updateDisplayName(String name) async {
    try {
      await _auth.currentUser?.updateDisplayName(name);
      notifyListeners();
      return null;
    } catch (e) {
      return 'Failed to update name. Try again.';
    }
  }

  Future<String?> uploadAndUpdatePhotoURL() async {
    final file = await _storageService.pickImageFromGallery();
    if (file == null) return null;

    final downloadUrl = await _storageService.uploadProfilePhoto(
      userId: _auth.currentUser!.uid,
      file: file,
    );

    if (downloadUrl == null) return 'Failed to upload photo, Try again.';

    await _auth.currentUser?.updatePhotoURL(downloadUrl);
    notifyListeners();
    return null;
  }

  Future<String?> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  Future<String?> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: currentPassword,
      );

      await _auth.currentUser!.reauthenticateWithCredential(credential);

      await _auth.currentUser!.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

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
