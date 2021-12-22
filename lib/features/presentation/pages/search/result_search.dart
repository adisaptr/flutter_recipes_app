import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../injection_container.dart';
import '../../../domain/entities/recipe_by_search.dart';
import '../../bloc/recipe_by_search_bloc/bloc/recipe_by_search_bloc.dart';
import '../detail/main.dart';

class ResultSearch extends StatelessWidget {
  final search;
  const ResultSearch({Key? key, required this.search}) : super(key: key);

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
          search,
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

  BlocProvider<RecipeBySearchBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeBySearchBloc>();
        bloc.add(GetDataForRecipeSearch(search));
        return bloc;
      },
      child: BlocBuilder<RecipeBySearchBloc, RecipeBySearchState>(
        builder: (context, state) {
          if (state is Loaded) {
            if (state.recipe.length == 0) {
              return Center(
                child: Text('Resep Tidak ditemukan'),
              );
            } else
              return _buildListRecommendation(state.recipe, context);
          } else if (state is Error) {
            return Center(
              child:
                  Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
            );
          }
          return _shimmerList();
        },
      ),
    );
  }

  _buildListRecommendation(List<RecipeBySearch> lists, BuildContext context) {
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
