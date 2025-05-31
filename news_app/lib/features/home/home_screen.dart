import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/home/home_controller.dart';

import 'package:news_app/features/home/widgets/category_list_widget.dart';
import 'package:news_app/features/home/widgets/news_card.dart';
import 'package:news_app/features/home/widgets/trending_news_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        body: Consumer<HomeController>(
          builder:
              (BuildContext context, HomeController controller, Widget? child) {
                return (CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: TrendingNews(
                        isLoading: controller.isLoadingHeadlines,
                        articles: controller.topHeadlines,
                        formatTimeAgo: controller.formatTimeAgo,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: CategoryList(
                          categories: controller.categories,
                          selectedCategory: controller.selectedCategory,
                          onCategorySelected: (category) {
                            controller.changeCategory(category);
                          },
                        ),
                      ),
                    ),
                    controller.isLoadingEverything
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: ValueListenableBuilder(
                              valueListenable: Hive.box(
                                'bookmarks',
                              ).listenable(),
                              builder: (context, Box box, _) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.everythingArticles.length,
                                  itemBuilder: (context, index) {
                                    final article =
                                        controller.everythingArticles[index];
                                    final isBookmarked = box.containsKey(
                                      article.url,
                                    );
                                    return NewsCard(
                                      article: article,
                                      isBookmarked: isBookmarked,
                                      formatTimeAgo: controller.formatTimeAgo,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                  ],
                ));
              },
        ),
      ),
    );
  }
}
