import 'package:flutter/material.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class PasswordStrenghtIndicator extends StatelessWidget {
  const PasswordStrenghtIndicator({super.key, required this.password});
  final String password;

  _PasswordStrenght get _strength {
    if (password.isEmpty) return _PasswordStrenght.none;
    if (password.length < 6) return _PasswordStrenght.weak;

    bool hasUpper = password.contains(RegExp(r'[A-Z]'));
    bool hasNumber = password.contains(RegExp(r'[0-9]'));
    bool hasSpecial = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool longEnough = password.length >= 8;
    int score = 0;
    if (longEnough) score++;
    if (hasUpper) score++;
    if (hasNumber) score++;
    if (hasSpecial) score++;

    if (score <= 1) return _PasswordStrenght.fair;
    if (score == 2) return _PasswordStrenght.good;
    return _PasswordStrenght.strong;
  }

  @override
  Widget build(BuildContext context) {
    if (_strength == _PasswordStrenght.none) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Row(
          children: List.generate(4, (index) {
            final filled = index < _strength.level;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 4, left: 4),
                height: 4,
                decoration: BoxDecoration(
                  color: filled
                      ? _strength.color
                      : AppColors.surfaceContainerHigh,
                  // borderRadius: BorderRadius.circular(99),
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 4),

        Text(
          _strength.label,
          style: AppTypography.caption.copyWith(color: _strength.color),
        ),
      ],
    );
  }
}

enum _PasswordStrenght {
  none(level: 0, label: '', color: Colors.transparent),
  weak(level: 1, label: 'Weak', color: Colors.red),
  fair(level: 2, label: 'Fair', color: Colors.orange),
  good(level: 3, label: 'Good', color: Colors.blue),
  strong(level: 4, label: 'Strong', color: Colors.green);

  const _PasswordStrenght({
    required this.level,
    required this.label,
    required this.color,
  });
  final int level;
  final String label;
  final Color color;
}
