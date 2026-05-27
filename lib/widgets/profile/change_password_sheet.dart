import 'package:flutter/material.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/components/app_button.dart';
import 'package:news_app/widgets/components/app_text_form_field.dart';
import 'package:provider/provider.dart';








class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({super.key});

  @override
  State<ChangePasswordSheet> createState() => ChangePasswordSheetState();
}

class ChangePasswordSheetState extends State<ChangePasswordSheet> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final error = await context.read<AuthProvider>().updatePassword(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (error != null) {
      setState(() => _error = error);
    } else {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Change Password', style: AppTypography.headline),
          const SizedBox(height: 24),

          AppTextFormField(
            label: 'Current Password',
            controller: _currentPasswordController,
            obscureText: _obscureCurrent,
            textInputAction: TextInputAction.next,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureCurrent
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.onSurfaceVariant,
              ),
              onPressed: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
            ),
          ),

          const SizedBox(height: 12),

          AppTextFormField(
            label: 'New Password',
            controller: _newPasswordController,
            obscureText: _obscureNew,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _changePassword(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNew
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.onSurfaceVariant,
              ),
              onPressed: () => setState(() => _obscureNew = !_obscureNew),
            ),
          ),

          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: AppTypography.caption.copyWith(color: AppColors.error),
            ),
          ],

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: 'Update Password',
              isLoading: _isLoading,
              onPressed: _changePassword,
            ),
          ),
        ],
      ),
    );
  }
}
