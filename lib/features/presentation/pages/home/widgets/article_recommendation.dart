import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../injection_container.dart';
import '../../../../domain/entities/recipe_article.dart';
import '../../../bloc/recipe_article_bloc/bloc/recipe_article_bloc.dart';
import '../../detail_article/main.dart';

class ArticleRecommendation extends StatelessWidget {
  final count;
  const ArticleRecommendation({Key? key, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<RecipeArticleBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeArticleBloc>();
        bloc.add(GetDataForRecipeArticle());
        return bloc;
      },
      child: BlocBuilder<RecipeArticleBloc, RecipeArticleState>(
        builder: (context, state) {
          if (state is Loaded) {
            return _buildListRecommendation(state.article, context);
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

  _buildListRecommendation(List<RecipeArticle> lists, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF16c79e),
                ),
                width: 80,
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.book_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              title: Text(
                lists[index].title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                var url = lists[index].url;
                var keyArticle =
                    url.replaceAll('https://www.masakapahariini.com/', '');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailArticle(keyArticle: keyArticle),
                  ),
                );
              },
            ),
          );
        },
        childCount: count ? lists.length : 4,
      ),
    );
  }

  _shimmerList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Shimmer.fromColors(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
              child: ListTile(
                leading: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                ),
                title: Container(
                  width: double.infinity,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ),
            ),
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100);
      }, childCount: count ? 10 : 4),
    );
  }
}
