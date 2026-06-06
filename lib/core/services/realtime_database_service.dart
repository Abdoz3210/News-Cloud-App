import 'dart:convert';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class RealtimeDatabaseService {
  RealtimeDatabaseService._() {
    _database.ref('users').keepSynced(true);
  }
  static final RealtimeDatabaseService instance = RealtimeDatabaseService._();

  final _database = FirebaseDatabase.instance;
  final _picker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 512,
    );

    if (picked == null) return null;
    return File(picked.path);
  }

  Future<String?> saveUserPhoto({
    required String userId,
    required File file,
  }) async {
    try {
      final bytes = await file.readAsBytes();
      final base64String = base64Encode(bytes);

      print('bytes length: ${bytes.length}');
      print('base64 lenght: ${base64String.length}');

      // final dataUrl = 'data:image/jpeg;base64,$base64String';

      await _database.ref('users/$userId/photoBase64').set(base64String);
      print('saved successfully');
      print('saving to path: users/$userId/photoBase64');

      return null;
    } catch (e) {
      print('savedUserPhoto errer: $e');
      return 'Failed to save photo. Try again.';
    }
  }

  // Future<String?> getUserPhoto(String userId) async {
  //   try {
  //     final snapshot = await _database.ref('user/$userId/photoBase64').get();
  //     print('photo exists: ${snapshot.exists}'); // ← add
  //     print(
  //       'photo value length: ${snapshot.value?.toString().length}',
  //     ); // ← add
  //     print('reading from path: users/$userId/photoBase64');
  //     if (!snapshot.exists) return null;
  //     return snapshot.value as String?;
  //   } catch (e) {
  //     print('getUserPhoto error: $e');
  //     return null;
  //   }
  // }

  Stream<String?> watchUserPhoto(String userId) {
    return _database.ref('users/$userId/photoBase64').onValue
    // ↑ stream that fires every time the value changes
    // ↑ also fires immediately with current value on subscribe
    .map((event) {
      if (!event.snapshot.exists) return null;
      return event.snapshot.value as String?;
    });
  }

  Future<void> deleteUserData(String userId) async {
    try {
      await _database.ref('user/$userId').remove();
    } catch (e) {
      print(e);
    }
  }
}
