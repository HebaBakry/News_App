import 'package:flutter/material.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repositories/base_news_api_repository.dart';

class SearchProvider with ChangeNotifier {
  List<NewsArticle> articles = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> searchNews(String query) async {
    if (query.isEmpty) {
      articles = [];
      errorMessage = null;
      ;
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final repository = locator<BaseNewsApiRepository>();
      final result = await repository.fetchEverything(query: query);

      articles = result;
    } catch (e) {
      errorMessage = 'Failed to load news: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
