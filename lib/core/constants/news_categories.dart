class NewsCategory {
  final String label;
  final String apiValue;
  const NewsCategory({required this.label, required this.apiValue});
}

const List<NewsCategory> NewsCategories = [
  NewsCategory(label: 'Top Stories', apiValue: 'general'),
  NewsCategory(label: 'Business', apiValue: 'business'),
  NewsCategory(label: 'Technology', apiValue: 'technology'),
  NewsCategory(label: 'Science', apiValue: 'science'),
  NewsCategory(label: 'Health', apiValue: 'health'),
  NewsCategory(label: 'Sports', apiValue: 'sports'),
  NewsCategory(label: 'Culture', apiValue: 'entertainment'),
];
