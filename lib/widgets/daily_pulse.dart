import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Models/articales_model.dart';
import 'package:news_app/core/services/getnews.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class DailyPulseSection extends StatefulWidget {
  const DailyPulseSection({super.key});

  @override
  State<DailyPulseSection> createState() => _DailyPulseSectionState();
}

class _DailyPulseSectionState extends State<DailyPulseSection> {
  late Future<List<ArticalModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = NewsServce(Dio()).getHeadlines(pageSize: 2);
  }

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
            const _PulseHeader(),
            FutureBuilder<List<ArticalModel>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const _PulseSkeleton();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const _PulseError();
                }

                final articles = snapshot.data!;
                return Column(
                  children: List.generate(articles.length, (index) {
                    final article = articles[index];
                    final isLast = index == articles.length - 1;
                    return _PulseItems(article: article, showDivider: !isLast);
                  }),
                );
              },
            ),
            const _ViewArchiveLink(),
          ],
        ),
      ),
    );
  }
}

class _PulseHeader extends StatelessWidget {
  const _PulseHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: [
          Text(
            'DAILY PULSE',
            style: AppTypography.categoryTag.copyWith(
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.1,
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            'LIVE',
            style: AppTypography.caption.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PulseItems extends StatelessWidget {
  const _PulseItems({required this.article, required this.showDivider});
  final ArticalModel article;
  final bool showDivider;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.sourceName.toUpperCase(),
                      style: AppTypography.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),

                    Text(
                      article.title ?? '',
                      style: AppTypography.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(article.relativeTime, style: AppTypography.caption),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.5,
            indent: 34,
            endIndent: 16,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
          ),
      ],
    );
  }
}

class _PulseError extends StatelessWidget {
  const _PulseError();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Could not load headlines.',
        style: AppTypography.caption.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ViewArchiveLink extends StatelessWidget {
  const _ViewArchiveLink();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {
            // navigate to Explore — Issue 20
          },
          child: Text(
            'VIEW ARCHIVE →',
            style: AppTypography.caption.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.05,
            ),
          ),
        ),
      ),
    );
  }
}

class _PulseSkeleton extends StatelessWidget {
  const _PulseSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(2, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // dot skeleton
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // source skeleton
                    Container(
                      height: 10,
                      width: 60,
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),
                    const SizedBox(height: 6),
                    // headline skeleton
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 12,
                      width: 180,
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),
                    const SizedBox(height: 4),
                    // time skeleton
                    Container(
                      height: 10,
                      width: 60,
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
