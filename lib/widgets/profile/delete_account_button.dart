import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/widgets/components/app_text_form_field.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () => _showDeleteConfirmation(context),
        child: Text(
          'DEACTIVATE CHRONICLER ACCOUNT',
          style: AppTypography.caption.copyWith(
            color: AppColors.error,
            letterSpacing: 0.05,
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => _DeleteAccountDialog(),
    );
  }
}

class _DeleteAccountDialog extends StatefulWidget {
  const _DeleteAccountDialog();

  @override
  State<_DeleteAccountDialog> createState() => __DeleteAccountDialogState();
}

class __DeleteAccountDialogState extends State<_DeleteAccountDialog> {
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _deleteAccount() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final error = await context.read<AuthProvider>().deleteAccount(
      password: _passwordController.text,
    );
    if (!mounted) return;

    if (error != null) {
      setState(() {
        _isLoading = false;
        _error = error;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Deactive Account',
        style: AppTypography.headline.copyWith(color: AppColors.error),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This action is permanent and cannot be undone.'
            'All your saved stories and perference will be lost.',
            style: AppTypography.body,
          ),
          const SizedBox(height: 16),

          Text('Enter your password to confirm:', style: AppTypography.labelMd),
          const SizedBox(height: 8),

          AppTextFormField(
            label: 'Password',
            controller: _passwordController,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _deleteAccount(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(
              _error!,
              style: AppTypography.caption.copyWith(color: AppColors.error),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: AppTypography.labelLg),
        ),
        TextButton(
          onPressed: _isLoading ? null : _deleteAccount,
          child: _isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(
                  'Deactivate',
                  style: AppTypography.labelLg.copyWith(color: AppColors.error),
                ),
        ),
      ],
    );
  }
}
