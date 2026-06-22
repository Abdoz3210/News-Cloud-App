import 'package:flutter/material.dart';

class NewsCategory {
  final String label;
  final String apiValue;
  final IconData? icons;
  const NewsCategory({required this.label, required this.apiValue, this.icons});
}

const List<NewsCategory> NewsCategories = [
  NewsCategory(
    label: 'Top Stories',
    apiValue: 'general',
    icons: Icons.public_rounded,
  ),
  NewsCategory(
    label: 'Business',
    apiValue: 'business',
    icons: Icons.business_center_outlined,
  ),
  NewsCategory(
    label: 'Technology',
    apiValue: 'technology',
    icons: Icons.code_rounded,
  ),
  NewsCategory(
    label: 'Science',
    apiValue: 'science',
    icons: Icons.science_rounded,
  ),
  NewsCategory(
    label: 'Health',
    apiValue: 'health',
    icons: Icons.healing_rounded,
  ),
  NewsCategory(
    label: 'Sports',
    apiValue: 'sports',
    icons: Icons.sports_rounded,
  ),
  NewsCategory(
    label: 'Culture',
    apiValue: 'entertainment',
    icons: Icons.palette_outlined,
  ),
];
