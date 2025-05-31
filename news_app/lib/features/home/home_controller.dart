import 'package:flutter/material.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repositories/base_news_api_repository.dart';

class HomeController with ChangeNotifier {
  final BaseNewsApiRepository _repository = locator<BaseNewsApiRepository>();
  List<NewsArticle> topHeadlines = [];
  List<NewsArticle> everythingArticles = [];
  bool isLoadingHeadlines = true;
  bool isLoadingEverything = true;
  String selectedCategory = 'Top News';

  final List<String> categories = [
    'Top News',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  init() {
    loadNews();
  }

  Future<void> loadNews() async {
    isLoadingHeadlines = true;
    isLoadingEverything = true;

    try {
      final headlines = await _repository.fetchTopHeadlines(
        category: selectedCategory == 'Top News' ? 'general' : selectedCategory,
      );
      topHeadlines = headlines;
      isLoadingHeadlines = false;
    } catch (_) {
      topHeadlines = [];
      isLoadingHeadlines = false;
    }

    try {
      final everything = await _repository.fetchEverything(
        query: selectedCategory == 'Top News' ? 'news' : selectedCategory,
      );
      everythingArticles = everything;
      isLoadingEverything = false;
    } catch (_) {
      everythingArticles = [];
      isLoadingEverything = false;
    }
    notifyListeners();
  }

  String formatTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  void changeCategory(String category) {
    selectedCategory = category;
    loadNews();
    notifyListeners();
  }
}
