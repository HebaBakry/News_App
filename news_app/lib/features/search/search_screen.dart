import 'package:flutter/material.dart';
import 'package:news_app/core/extentions/extentions.dart';
import 'package:news_app/features/home/widgets/news_card.dart';
import 'package:provider/provider.dart';
import 'package:news_app/features/search/search_controller.dart';

/// TODO : Task - Add Controller To It
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (context) => SearchProvider(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search News')),
        body: Consumer<SearchProvider>(
          builder:
              (BuildContext context, SearchProvider controller, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for news...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onSubmitted: controller.searchNews,
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: controller.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : controller.errorMessage != null
                            ? Center(child: Text(controller.errorMessage!))
                            : controller.articles.isEmpty
                            ? const Center(child: Text('No results found'))
                            : ListView.builder(
                                itemCount: controller.articles.length,
                                itemBuilder: (context, index) {
                                  final article = controller.articles[index];
                                  return GestureDetector(
                                    onTap: () {},
                                    child: NewsCard(
                                      article: article,
                                      isBookmarked: true,

                                      formatTimeAgo: (time) =>
                                          time.formatTimeAgo(),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
