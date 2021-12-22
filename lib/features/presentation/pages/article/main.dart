import 'package:flutter/material.dart';

import '../home/widgets/article_recommendation.dart';
import 'widgets/article_category.dart';

class ArticleRecipe extends StatefulWidget {
  const ArticleRecipe({Key? key}) : super(key: key);

  @override
  _ArticleRecipeState createState() => _ArticleRecipeState();
}

class _ArticleRecipeState extends State<ArticleRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: const [
          SliverAppBar(
            title: Text(
              'Artikel',
              style: TextStyle(
                color: Color(0xFF109173),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            stretch: true,
            backgroundColor: Colors.white,
          ),
          ArticleCategory(),
          ArticleRecommendation(count: true),
        ],
      ),
    );
  }
}
