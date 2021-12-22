import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../injection_container.dart';
import '../../../../domain/entities/recipe_category.dart';
import '../../../bloc/recipe_category_bloc/bloc/recipe_category_bloc.dart';
import '../../list_recipe_by_category/main.dart';

class CategoryRecipe extends StatelessWidget {
  final count;
  const CategoryRecipe({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<RecipeCategoryBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeCategoryBloc>();
        bloc.add(GetDataForRecipeCategory());
        return bloc;
      },
      child: BlocBuilder<RecipeCategoryBloc, RecipeCategoryState>(
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

  _buildListRecommendation(List<RecipeCategory> lists, BuildContext context) {
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ListRecipeCategory(
                        title: lists[index].category,
                        keyRecipe: lists[index].key,
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
                        Icons.food_bank_outlined,
                        color: Color(0xFF16c79e),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          lists[index].category,
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
        childCount: count ? lists.length : 6,
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
        childCount: 6,
      ),
    );
  }
}
