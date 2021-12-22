import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../injection_container.dart';
import '../../../domain/entities/recipe.dart';
import '../../bloc/recipe_by_category_bloc/bloc/recipe_by_category_bloc.dart';
import '../detail/main.dart';

class ListRecipeCategory extends StatelessWidget {
  final title, keyRecipe;
  const ListRecipeCategory(
      {Key? key, required this.title, required this.keyRecipe})
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

  BlocProvider<RecipeByCategoryBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeByCategoryBloc>();
        bloc.add(GetDataForRecipeList(keyRecipe));
        return bloc;
      },
      child: BlocBuilder<RecipeByCategoryBloc, RecipeByCategoryState>(
        builder: (context, state) {
          if (state is Loaded) {
            return _buildListRecommendation(state.recipe, context);
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

  _buildListRecommendation(List<Recipe> lists, BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailRecipe(
                      keyRecipe: lists[index].key,
                    ),
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
