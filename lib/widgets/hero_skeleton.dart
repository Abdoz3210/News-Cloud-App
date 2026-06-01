import 'package:flutter/material.dart';

class HeroSkeleton extends StatelessWidget {
  const HeroSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image skeleton
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // category chip skeleton
                  Container(
                    height: 24,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // title skeleton lines
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 16,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 16,
                    width: 200,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                  const SizedBox(height: 12),
                  // metadata skeleton
                  Container(
                    height: 12,
                    width: 150,
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
