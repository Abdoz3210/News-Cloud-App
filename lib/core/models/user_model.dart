import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String displayName;
  final String? email;
  final String? photoURL;
  final DateTime? createdAt;
  final bool emailVerified;

  const UserModel({
    required this.uid,
    required this.displayName,
    this.email,
    this.photoURL,
    this.createdAt,
    required this.emailVerified,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      uid: user.uid,
      displayName: user.displayName ?? 'Chronicler Member',
      email: user.email,
      photoURL: user.photoURL,
      createdAt: user.metadata.creationTime,
      emailVerified: user.emailVerified,
    );
  }

  String get joinDate {
    if (createdAt == null) return '--';
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
    return '${months[createdAt!.month - 1]} ${createdAt!.year}';
  }

  String get firstName {
    return displayName.split(' ').first;
  }

  UserModel copyWith({
    String? displayName,
    String? email,
    String? photoURL,
    bool? emailVerified,
  }) {
    return UserModel(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, displayName: $displayName, email: $email)';
  }
}
