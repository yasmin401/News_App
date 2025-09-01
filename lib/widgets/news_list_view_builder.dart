import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/news_services.dart';
import 'package:news_app/widgets/news_list_view.dart';

// class NewsListViewBuilder extends StatefulWidget {
//   const NewsListViewBuilder({super.key});
//   @override
//   State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
// }
// class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
//   List<ArticleModel> articles = [];
//   bool isLoading = true;
//   @override
//   void initState() {
//     super.initState();
//     getGeneralNews();
//   }
//   Future<void> getGeneralNews() async {
//     articles = await NewsServices(Dio()).getNews();
//     isLoading = false;
//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const SliverFillRemaining(
//             hasScrollBody: false,
//             child: Center(child: CircularProgressIndicator()),
//           )
//         : articles.isNotEmpty
//         ? NewsListView(articles: articles)
//         : const SliverFillRemaining(
//             child: Center(child: Text('OOPS There Was an Error,Try Later.')),
//           );
//   }
// }

class NewsListViewBuilder extends StatefulWidget {
  const NewsListViewBuilder({super.key, required this.category});
  final String category;
  @override
  State<NewsListViewBuilder> createState() => _NewsListViewBuilderState();
}

class _NewsListViewBuilderState extends State<NewsListViewBuilder> {
  var future;
  @override
  void initState() {
    super.initState();
    future = NewsServices(Dio()).getTopHeadlines(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsListView(articles: snapshot.data!);
        } else if (snapshot.hasError) {
          return const SliverFillRemaining(
            child: Center(child: Text('OOPS There Was an Error,Try Later.')),
          );
        } else {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
