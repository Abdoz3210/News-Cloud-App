import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:news_app/Models/articales_model.dart';
import 'package:news_app/core/services/getnews.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';

class NewsDetailView extends StatefulWidget {
  const NewsDetailView({super.key, required this.articale});

  final ArticalModel articale;

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView> {
  late Future<List<ArticalModel>> _relatedFuture;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _relatedFuture = NewsServce(
      Dio(),
    ).getGeneral(category: widget.articale.category ?? 'general');
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.articale;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            iconTheme: const IconThemeData(color: AppColors.onPrimary),
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroImageWidgetGradient(image: article.image),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _categoryPill(label: article.sourceName),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.schedule_rounded,
                        size: 14,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),

                      Text(
                        '${article.readTimeMinutes} Min Read',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Text(
                    article.title ?? 'Untitled',
                    style: AppTypography.displayLg,
                  ),

                  const SizedBox(height: 20),

                  _AuthorRow(article: article),

                  const SizedBox(height: 24),

                  _DropCapBody(paragraphs: article.contentParagraphs),

                  const SizedBox(height: 24),

                  if (article.descriptation != null)
                    _styledBlockQuote(quote: article.descriptation),

                  const SizedBox(height: 24),

                  _AuthorBioCard(
                    article: article,
                    isFollowing: _isFollowing,
                    onFollowToggle: () {
                      setState(() {
                        _isFollowing = !_isFollowing;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _furtherReadingSection(
              future: _relatedFuture,
              currentArticalUrl: article.url,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _furtherReadingSection extends StatelessWidget {
  const _furtherReadingSection({
    required this.future,
    required this.currentArticalUrl,
  });
  final Future<List<ArticalModel>>? future;
  final String? currentArticalUrl;
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}

class _styledBlockQuote extends StatelessWidget {
  const _styledBlockQuote({required this.quote});
  final String? quote;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(quote!));
  }
}

class _AuthorBioCard extends StatelessWidget {
  const _AuthorBioCard({
    required this.article,
    this.isFollowing = false,
    required this.onFollowToggle,
  });
  final ArticalModel article;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(article.author!));
  }
}

class _DropCapBody extends StatelessWidget {
  const _DropCapBody({required this.paragraphs});

  final List<String> paragraphs;

  @override
  Widget build(BuildContext context) {
    if (paragraphs.isEmpty) {
      return Text(
        'Full article content is not available from this source.',
        style: AppTypography.bodySerif.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(paragraphs.length, (index) {
        final isFirst = index == 0;
        final paragraph = paragraphs[index];

        return Padding(padding: const EdgeInsets.only(bottom: 16),
        child: isFirst ?_DropCapParagraph(text: paragraph) : Text(paragraph,style: AppTypography.bodySerif,),
        );
      }),
    );
  }
}

class _DropCapParagraph extends StatelessWidget{
  const _DropCapParagraph({required this.text});
  final String text;
  
  @override 
  Widget build(BuildContext context){
    return Container(child: Text(text),);
  }
}

class _AuthorRow extends StatelessWidget {
  const _AuthorRow({required this.article});
  final ArticalModel article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.surfaceContainerHigh,
          child: Icon(Icons.person_rounded, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.author ?? 'UnKnown Author',
                style: AppTypography.titleMd,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(article.formattedDate, style: AppTypography.caption),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroImageWidgetGradient extends StatelessWidget {
  const _HeroImageWidgetGradient({required this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (image != null)
          Image.network(
            image!,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
          )
        else
          Container(color: Theme.of(context).colorScheme.surfaceContainerHigh),

        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.4),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.1),
              ],
              // stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}

class _categoryPill extends StatelessWidget {
  const _categoryPill({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.categoryTag.copyWith(color: AppColors.primary),
      ),
    );
  }
}
