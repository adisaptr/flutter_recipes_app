import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../injection_container.dart';
import '../../../bloc/recipe_bloc/bloc/recipe_bloc.dart';
import '../../detail/main.dart';

List<Widget> imageSliders = [];

class SlidingRecommendation extends StatefulWidget {
  const SlidingRecommendation({Key? key}) : super(key: key);

  @override
  _SlidingRecommendationState createState() => _SlidingRecommendationState();
}

class _SlidingRecommendationState extends State<SlidingRecommendation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: buildBody(context),
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
            for (var a = 1; a <= 5; a++) {
              imageSliders.add(Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DetailRecipe(
                                      keyRecipe: state.recipe[a].key,
                                    )));
                      },
                      child: Stack(
                        children: <Widget>[
                          Image.network(state.recipe[a].thumb,
                              fit: BoxFit.cover, width: 1000.0),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: const [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                state.recipe[a].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ));
            }
            return Container(
                child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
              ),
              items: imageSliders,
            ));
          } else if (state is Error) {
            return Center(child: Text('Error'));
          } else if (state is Loading) {
            return Shimmer.fromColors(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                  ),
                ),
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100);
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
}
