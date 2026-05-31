import 'package:flutter/material.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/profile/section_card.dart';
import 'package:news_app/widgets/components/app_button.dart';
import 'package:news_app/widgets/components/app_text_form_field.dart';
import 'package:provider/provider.dart';

class PersonalInfoDection extends StatefulWidget {
  const PersonalInfoDection({super.key});

  @override
  State<PersonalInfoDection> createState() => PersonalInfoDectionState();
}

class PersonalInfoDectionState extends State<PersonalInfoDection> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isLoading = false;
  String? _message;

  @override
  void initState() {
    super.initState();

    final auth = context.read<AuthProvider>();

    _nameController = TextEditingController(text: auth.displayName);
    _emailController = TextEditingController(text: auth.userEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
      _message = null;
    });
    final auth = context.read<AuthProvider>();

    final nameError = await auth.updateDisplayName(_nameController.text.trim());

    String? emailError;
    if (_emailController.text.trim() != auth.userEmail) {
      emailError = await auth.updateEmail(_emailController.text.trim());
    }
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      _message =
          nameError ??
          emailError ??
          (emailError == null && _emailController.text.trim() != auth.userEmail
              ? 'Profile updated! Check your email to verify the new address.'
              : 'Profile updated successfully!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Personal Information',
      icon: Icons.person_outline_rounded,
      children: [
        AppTextFormField(
          label: 'Fullname',
          controller: _nameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 12),

        AppTextFormField(
          label: 'Email Address',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _updateProfile(),
        ),
        SizedBox(height: 8),
        Text(
          'A verification email will be sent to confirm any email changes.',
          style: AppTypography.caption.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        if (_message != null) ...[
          const SizedBox(height: 8),
          Text(
            _message!,
            style: AppTypography.caption.copyWith(
              color: _message!.contains('success')
                  ? AppColors.primary
                  : AppColors.error,
            ),
          ),
        ],
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerRight,
          child: AppButton(
            label: 'Update Profile',
            onPressed: _updateProfile,
            isLoading: _isLoading,
          ),
        ),
      ],
    );
  }
}
