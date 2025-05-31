import 'package:flutter/material.dart';
import 'package:news_app/core/extentions/extentions.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'News Details',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey.shade300,
                image:
                    article.urlToImage != null && article.urlToImage!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(article.urlToImage!),
                        fit: BoxFit.cover,
                        onError: (_, __) {
                          print('Error loading image: ${article.urlToImage}');
                        },
                      )
                    : null,
              ),
              child: (article.urlToImage == null || article.urlToImage!.isEmpty)
                  ? null
                  : null,
            ),

            const SizedBox(height: 16),
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.fiber_manual_record,
                  size: 12,
                  color: Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  article.sourceName,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(width: 16),
                Text(
                  article.publishedAt.formatTimeAgo(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const Spacer(),
                Icon(Icons.share, color: Theme.of(context).iconTheme.color),

                GestureDetector(
                  child: const Icon(Icons.bookmark_border),
                  onTap: () {
                    print('Bookmark tapped');
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              article.description ?? 'No description available.',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
