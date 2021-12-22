import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../injection_container.dart';
import '../../bloc/recipe_article_detail_bloc/bloc/recipe_article_detail_bloc.dart';

class DetailArticle extends StatelessWidget {
  final keyArticle;
  const DetailArticle({Key? key, required this.keyArticle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  BlocProvider<RecipeArticleDetailBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeArticleDetailBloc>();
        bloc.add(GetDataForRecipeArticleDetail(keyArticle));
        return bloc;
      },
      child: BlocBuilder<RecipeArticleDetailBloc, RecipeArticleDetailState>(
        builder: (context, state) {
          if (state is Loaded) {
            return _loaded(context, state.article);
          } else if (state is Error) {
            return Center(child: Text('Error'));
          } else if (state is Loading) {
            return _loading(context);
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  _loaded(context, recipe) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.fromLTRB(14, 0, 0, 0),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          pinned: true,
          expandedHeight: 250,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            background: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                        colors: const [Colors.black45, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)
                    .createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.darken,
              child: Image.network(
                recipe.thumb,
                fit: BoxFit.cover,
              ),
            ),
            collapseMode: CollapseMode.pin,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${recipe.title}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'by ${recipe.author}, ${recipe.datePublished}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
            child: Text(
              recipe.description,
              textAlign: TextAlign.justify,
            ),
          ),
        )
      ],
    );
  }

  _loading(context) {
    return Shimmer.fromColors(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              expandedHeight: 300,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                            colors: const [Colors.black45, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)
                        .createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.darken,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                collapseMode: CollapseMode.pin,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.grey[200],
                      ),
                    ),
                  );
                },
                childCount: 15,
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Container(
            //       height: 200,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(8.0),
            //         color: Colors.grey[200],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100);
  }
}
