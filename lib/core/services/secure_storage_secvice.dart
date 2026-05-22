import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageSecvice {
  SecureStorageSecvice._();
  static final SecureStorageSecvice instance = SecureStorageSecvice._();

  final _storge = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const String _keyOnboarded = 'onboarded';
  static const String _keyUserEmail = 'user_email';

  Future<void> setOnboarded() async {
    await _storge.write(key: _keyOnboarded, value: 'true');
  }

  Future<bool> isOnboarded() async {
    final value = await _storge.read(key: _keyOnboarded);
    return value == 'true';
  }

  Future<void> saveUserEmail(String email) async {
    await _storge.write(key: _keyUserEmail, value: email);
  }

  Future<String?> getUserEmail() async {
    return await _storge.read(key: _keyUserEmail);
  }

  Future<void> clearAll() async {
    await _storge.deleteAll();
  }
}
