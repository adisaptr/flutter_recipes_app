import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../injection_container.dart';
import '../../../domain/entities/recipe.dart';
import '../../bloc/recipe_bloc/bloc/recipe_bloc.dart';
import '../detail/main.dart';
import 'result_search.dart';

class SearchRecipe extends StatefulWidget {
  const SearchRecipe({Key? key}) : super(key: key);

  @override
  _SearchRecipeState createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  var controller = TextEditingController();
  bool clrBtn = false;
  void clearBtn() {
    setState(() {
      if (controller.text.isNotEmpty) {
        clrBtn = true;
      } else {
        clrBtn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: TextField(
              cursorColor: Color(0xFF16c79e),
              controller: controller,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                clearBtn();
              },
              onSubmitted: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ResultSearch(search: value)));
              },
              style: TextStyle(
                height: 1,
              ),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          onPressed: () => {
                            controller.clear(),
                            clearBtn(),
                          },
                          icon: Icon(Icons.clear),
                          color: Colors.black,
                        )
                      : null),
            ),
            // actions: [
            //   // if (clrBtn)
            //   InkWell(
            //     onTap: () {
            //       if (clrBtn) print('object');
            //     },
            //     child: Center(
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           'Search',
            //           style: TextStyle(
            //             color: Color(0xFF109173),
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //   )
            // ],
            stretch: true,
            backgroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Text('Rekomendasi',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          buildBody(context)
        ],
      ),
    );
  }

  BlocProvider<RecipeBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = sl<RecipeBloc>();
        bloc.add(GetDataForRecipe());
        return bloc;
      },
      child: BlocBuilder<RecipeBloc, RecipeState>(
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

  _shimmerList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
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
        },
        childCount: 10,
      ),
    );
  }

  _buildListRecommendation(List<Recipe> lists, BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
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
                            )));
              },
            ),
          );
        },
        childCount: lists.length,
      ),
    );
  }
}
