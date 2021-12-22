import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../injection_container.dart';
import '../../../../domain/entities/recipe_article_category.dart';
import '../../../bloc/recipe_article_category_bloc/bloc/recipe_article_category_bloc.dart';
import '../../list_article_by_category/main.dart';

class ArticleCategory extends StatelessWidget {
  const ArticleCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<RecipeArticleCategoryBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeArticleCategoryBloc>();
        bloc.add(GetDataForRecipeArticleCategory());
        return bloc;
      },
      child: BlocBuilder<RecipeArticleCategoryBloc, RecipeArticleCategoryState>(
        builder: (context, state) {
          if (state is Loaded) {
            return _buildListRecommendation(state.category, context);
          } else if (state is Error) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text('Error',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          }
          return _shimmerList();
        },
      ),
    );
  }

  _buildListRecommendation(
      List<RecipeArticleCategory> lists, BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  print(lists[index].key);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ListArticleCategory(
                        title: lists[index].title,
                        keyArticle: lists[index].key,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200],
                  ),
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book_rounded,
                        color: Color(0xFF16c79e),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          lists[index].title,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        childCount: lists.length,
      ),
    );
  }

  _shimmerList() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => Shimmer.fromColors(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    width: double.infinity,
                    height: 80,
                  ),
                ),
              ],
            ),
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100),
        childCount: 3,
      ),
    );
  }
}
