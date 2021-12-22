import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../injection_container.dart';
import '../../../domain/entities/recipe_article_by_category.dart';
import '../../bloc/recipe_article_by_category_bloc/bloc/recipe_article_by_category_bloc.dart';
import '../detail_article/main.dart';

class ListArticleCategory extends StatelessWidget {
  final title, keyArticle;
  const ListArticleCategory(
      {Key? key, required this.title, required this.keyArticle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF109173),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<RecipeArticleByCategoryBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeArticleByCategoryBloc>();
        bloc.add(GetDataForRecipeArticleList(keyArticle));
        return bloc;
      },
      child: BlocBuilder<RecipeArticleByCategoryBloc,
          RecipeArticleByCategoryState>(
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

  _buildListRecommendation(
      List<RecipeArticleByCategory> lists, BuildContext context) {
    return ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: ListTile(
              leading: Container(
                  color: Colors.grey[200],
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      lists[index].thumb,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )),
              title: Text(
                lists[index].title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                var key = '${keyArticle}/' + lists[index].key;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailArticle(keyArticle: key),
                  ),
                );
              },
            ),
          );
        });
  }

  _shimmerList() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
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
        });
  }
}
