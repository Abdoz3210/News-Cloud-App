import 'package:flutter/material.dart';
import 'package:news_app/Models/articales_model.dart';
import 'package:news_app/theme/app_colors.dart';
import 'package:news_app/theme/typography.dart';
import 'package:news_app/views/news_detail_view.dart';

class HeroArticleCard extends StatelessWidget {
  const HeroArticleCard({
    super.key,
    required this.artical,
    // required this.onTap,
  });
  final ArticalModel artical;
  // final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewsDetailView(articale: artical)),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 8, 16, 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroImage(imageUrl: artical.image),
            Padding(
              padding: const EdgeInsetsGeometry.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CategoryChip(label: artical.sourceName),
                      _BookmarkButton(artical: artical),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Text(
                    artical.title ?? 'Untitled',
                    style: AppTypography.displayMd,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  _MetadataRow(artical: artical),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (context, error, StackTrace) {
                return _ImagePlaceholder();
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return _ImageLoadingIndicato(progress: loadingProgress);
              },
            )
          : _ImagePlaceholder(),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 48,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _ImageLoadingIndicato extends StatelessWidget {
  const _ImageLoadingIndicato({required this.progress});
  final ImageChunkEvent progress;
  @override
  Widget build(BuildContext context) {
    final loaded = progress.cumulativeBytesLoaded;
    final total = progress.expectedTotalBytes;
    final percent = total != null ? loaded / total : null;
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Center(
        child: CircularProgressIndicator(
          value: percent,
          color: AppColors.primary,
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(99),
      ),

      child: Text(label.toUpperCase(), style: AppTypography.categoryTag),
    );
  }
}

class _BookmarkButton extends StatefulWidget {
  const _BookmarkButton({required this.artical});
  final ArticalModel artical;

  @override
  State<_BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<_BookmarkButton> {
  bool _isSaved = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isSaved = !_isSaved),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          _isSaved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
          key: ValueKey(_isSaved),
          color: _isSaved ? AppColors.primary : AppColors.onSurfaceVariant,
          size: 22,
        ),
      ),
    );
  }
}

class _MetadataRow extends StatelessWidget {
  const _MetadataRow({required this.artical});
  final ArticalModel artical;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.schedule_rounded,
          size: 14,
          color: AppColors.onSurfaceVariant,
        ),

        const SizedBox(width: 4),

        Text(
          '${artical.readTimeMinutes} min read',
          style: AppTypography.caption,
        ),

        const SizedBox(width: 16),
        Icon(
          Icons.person_outline_rounded,
          size: 14,
          color: AppColors.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            artical.author ?? 'Unknown Author',
            style: AppTypography.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
