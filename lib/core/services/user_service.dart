import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/core/services/notification_service.dart';
import 'package:news_app/core/services/secure_storage_secvice.dart';

class UserService {
  UserService._();

  static final UserService instance = UserService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? getProfile() {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebase(user);
  }

  Future<String?> updateDisplayName(String name) async {
    try {
      if (name.trim().isEmpty) return 'Name cannot be empty.';
      await _auth.currentUser?.updateDisplayName(name.trim());
      return null;
    } catch (e) {
      return 'Failed to update name. Try again';
    }
  }

  Future<String?> updateEmail(String newEmail) async {
    try {
      await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  Future<String?> updatePhotoURL(String url) async {
    try {
      await _auth.currentUser?.updateDisplayName(url);
      return null;
    } catch (e) {
      return 'Failed to update photo. Try again.';
    }
  }

  // TODO(M5): Uncomment when Firebase Storage (Blaze plan) is enabled
  // See: https://firebase.google.com/pricing
  // Future<String?> uploadAndUpdatePhotoURL() async {
  //   final file = await _storageService.pickImageFromGallery();
  //   if (file == null) return null;
  //   final downloadUrl = await _storageService.uploadProfilePhoto(
  //     userId: _auth.currentUser!.uid,
  //     file: file,
  //   );
  //   if (downloadUrl == null) return 'Failed to upload photo, Try again.';
  //   await _auth.currentUser?.updatePhotoURL(downloadUrl);
  //   notifyListeners();
  //   return null;
  // }
  

  Future<String?> changePassword({
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

  Future<void> signOut() async {
    await _auth.signOut();
    await SecureStorageSecvice.instance.clearAll();
    await NotificationService.instance.clearAll();
  }

  Future<String?> deleteAccount({required String password}) async {
    try {
      final credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: password,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);

      await SecureStorageSecvice.instance.clearAll();
      await NotificationService.instance.clearAll();

      await _auth.currentUser!.delete();
      return null;
    } on FirebaseAuthException catch (e) {
      return _mapError(e.code);
    }
  }

  String _mapError(String code) {
    switch (code) {
      case 'wrong-password':
        return 'Incorrect password. Try again.';
      case 'invalid-credential':
        return 'Incorrect password. Try again.';
      case 'requires-recent-login':
        return 'Please sign in again before making this change.';
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'network-request-failed':
        return 'No internet connection. Try again.';
      default:
        return 'Something went wrong. Try again.';
    }
  }
}
