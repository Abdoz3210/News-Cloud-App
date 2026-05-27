import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:news_app/views/main_view.dart';
import 'package:news_app/views/auth/sign_in_view.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Timer? _tokenTimer;

  void _startTokenCheck() {
    _tokenTimer = Timer.periodic(
      const Duration(minutes: 30),
      (_) => context.read<AuthProvider>().handleTokenExpiry(),
    );
  }

  @override
  void initState() {
    super.initState();
    _startTokenCheck();
  }

  @override
  void dispose() {
    _tokenTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const MainView();
        }

        return const SignInView();
      },
    );
  }
}
