import 'package:flutter/material.dart';
import 'package:news_app/core/utils/validators.dart';
import 'package:news_app/views/auth/sign_up_view.dart';
import 'package:news_app/widgets/components/app_text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/widgets/components/app_button.dart';
import 'package:news_app/widgets/components/app_input.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });
    final error = await context.read<AuthProvider>().signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (error != null) {
      setState(() {
        _errorMessage = error;
      });
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
              const SizedBox(height: 48),
              Text("Welcome", style: AppTypography.displayLg),
              Text(
                "Back",
                style: AppTypography.displayLg.copyWith(
                  color: AppColors.primary,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 16),
              Align(
                // alignment: Alignment.center,
                child: Text(
                  "Access your personalized editorial archive and curated news stories.",
                  style: AppTypography.pullQuote,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),

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
                        label: "subscriber Email",
                        hint: "name@chronicler.com",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: Validators.email,
                        autofocus: true,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                        // onChanged: (_) => setState(() {
                        // _errorMessage = null;
                        // }),
                      ),

                      const SizedBox(height: 16),

                      AppTextFormField(
                        label: "Secret Key",
                        hint: "••••••••",
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        validator: Validators.password,
                        onFieldSubmitted: (_) => _signIn(),

                        // onChanged: (_) => setState(() {
                        //   _errorMessage = null;
                        // }),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,

                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "FORGETTEN",
                            style: AppTypography.buttonLabel.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
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
                      SizedBox(height: 5),

                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          label: "Sign In ->",
                          onPressed: _signIn,
                          isLoading: _isLoading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // const SizedBox(width: 10),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "New to the archive?",
                    style: AppTypography.body,
                    children: [
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpView(),
                            ),
                          ),
                          child: Text(
                            "   Request Access",
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

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _FooterLink(label: 'Privacy'),
                  const SizedBox(width: 16),
                  _FooterLink(label: 'Terms'),
                  const SizedBox(width: 16),
                  _FooterLink(label: 'Support'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        label.toUpperCase(),
        style: AppTypography.caption.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}
