import 'package:flutter/material.dart';
//import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/theme/app_colors.dart';
//import 'package:provider/provider.dart';

class EditAvatarButton extends StatelessWidget {
  const EditAvatarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //final error = await context
        //  .read<AuthProvider>()
        //    .uploadAndUpdatePhotoURL();

        //if (!context.mounted) return;
        //if (error != null) {
        //  ScaffoldMessenger.of(context).showSnackBar(
        //    SnackBar(
        //      content: Text(error),
        //      backgroundColor: AppColors.error,
        //    ),
        //  );
        //}
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Photo upload coming soon!')),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          // color: AppColors.primary,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.surface,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.camera_alt_rounded,
          size: 14,
          color: AppColors.onPrimary,
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({this.photoUrl, super.key});
  final String? photoUrl;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.primaryGradient,
      ),
      child: CircleAvatar(
        radius: 70,
        backgroundColor: Colors.transparent,
        backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
        child: photoUrl == null
            ? Icon(
                Icons.person_rounded,
                size: 100,
                color: AppColors.onSurfaceVariant,
              )
            : null,
      ),
    );
  }
}
