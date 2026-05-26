
import 'package:flutter/material.dart';
import 'package:news_app/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class _UserHeader extends StatelessWidget {
  const _UserHeader();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().curentUser;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          Stack(children: [
              
            ],
          ),
        ],
      ),
    );
  }
}
