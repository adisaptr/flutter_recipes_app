import 'package:flutter/material.dart';
import 'package:recipes_app/features/presentation/pages/home/widgets/article_recommendation.dart';
import 'package:recipes_app/features/presentation/pages/home/widgets/recipe_category.dart';

import 'widgets/sliding_recommendation.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Resep Masak',
              style: TextStyle(
                color: Color(0xFF109173),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            stretch: true,
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: SlidingRecommendation(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kategori',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                  InkWell(
                    child: Text(
                      'Lihat Semua',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    onTap: () {
                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            slivers: const [
                              SliverToBoxAdapter(
                                child: Padding(padding: EdgeInsets.all(10.0)),
                              ),
                              CategoryRecipe(count: true),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          CategoryRecipe(count: false),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
              child: Text('Artikel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            ),
          ),
          ArticleRecommendation(count: false),
        ],
      ),
    );
  }
}
