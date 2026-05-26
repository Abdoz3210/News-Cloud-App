import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/validators.dart';
import 'package:news_app/widgets/components/app_text_form_field.dart';
import 'package:news_app/widgets/components/password_strenght_indicator.dart';
import 'package:provider/provider.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/components/app_button.dart';
import 'package:news_app/widgets/components/app_input.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirms = true;
  bool _isloading = false;
  bool _acceptedTerms = false;
  String? _errorMessage;
  late String _password = '';

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _vaildate() {
    if (_nameController.text.trim().isEmpty) {
      return 'Please enter your full name.';
    }
    if (_emailController.text.trim().isEmpty) {
      return 'Please enter your email address.';
    }
    if (_passwordController.text.trim().length < 8) {
      return 'Password must be at least 8 characters.';
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      return 'Passwords DO NOT match.';
    }
    if (!_acceptedTerms) {
      return 'Please accept the terms to continue.';
    }
    return null;
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptedTerms) {
      setState(() {
        _errorMessage = 'Please accept the terms to continue.';
        return;
      });
    }
    final validateError = _vaildate();
    if (validateError != null) {
      setState(() {
        _errorMessage = validateError;
      });
      return;
    }
    setState(() {
      _errorMessage = null;
      _isloading = true;
    });

    final error = await context.read<AuthProvider>().signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      username: _nameController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isloading = false;
    });
    if (error != null) {
      setState(() {
        _errorMessage = error;
      });
    }
    if (error == null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 38),
              Text(
                "Join",
                style: AppTypography.displayLg,
                textAlign: TextAlign.center,
              ),
              Text(
                "The Chroniclar",
                style: AppTypography.displayLg.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                  // fontSize: 38,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Create your Account and start reading.',
                style: AppTypography.pullQuote,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        label: "Full Name",
                        hint: 'Abdelrhman Salah',
                        validator: Validators.fullName,
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        // onChanged: (_) => setState(() => _errorMessage = null),
                      ),
                      SizedBox(height: 16),

                      AppTextFormField(
                        label: "Email Address",
                        hint: 'name@chroniler.com',
                        validator: Validators.email,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        // onChanged: (_) => setState(() => _errorMessage = null),
                      ),
                      SizedBox(height: 16),

                      AppTextFormField(
                        label: "Password",
                        hint: '••••••••',
                        controller: _passwordController,
                        validator: Validators.passwordStrong,
                        textInputAction: TextInputAction.next,
                        // keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscurePassword,
                        onChanged: (value) => setState(() => _password = value),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.onSurfaceVarianDark,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      PasswordStrenghtIndicator(password: _password),
                      SizedBox(height: 16),

                      AppTextFormField(
                        label: "Confirm Password",
                        hint: '••••••••',
                        validator: (value) =>
                            Validators.confirmPassword(value, _password),
                        controller: _confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        // keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscurePassword,
                        onChanged: (_) => setState(() => _errorMessage = null),
                        onFieldSubmitted: (_) => _signUp(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.onSurfaceVarianDark,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      Row(
                        children: [
                          Checkbox(
                            value: _acceptedTerms,
                            activeColor: AppColors.primary,
                            onChanged: (value) =>
                                setState(() => _acceptedTerms = value ?? false),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "I agree to the ",
                              style: AppTypography.caption,
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "Terms of Sevice",
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      if (_errorMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _errorMessage!,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          label: 'Sign Up',
                          onPressed: _signUp,
                          isLoading: _isloading,
                        ),
                      ),
                      const SizedBox(height: 32),

                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: 'Already a member? ',
                            style: AppTypography.body,
                            children: [
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    'Sign In',
                                    style: AppTypography.body.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
