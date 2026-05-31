import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  StorageService._();
  static final StorageService instance = StorageService._();

  final _storage = FirebaseStorage.instance;
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

  Future<String?> uploadProfilePhoto({
    required String userId,
    required File file,
  }) async {
    try {
      final ref = _storage.ref().child('profile_photo').child('$userId.jpg');
      final uploadTask = await ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }
}
