import 'package:flutter/material.dart';

class DetailFavorite extends StatelessWidget {
  final recipe;
  const DetailFavorite({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                      .createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height));
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
                      'by ${recipe.author.user}, ${recipe.author.datePublished}',
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
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
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
                              Icons.fastfood_rounded,
                              color: Color(0xFF16c79e),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text('${recipe.dificulty}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
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
                              Icons.timer_rounded,
                              color: Color(0xFF16c79e),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text('${recipe.times}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
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
                              Icons.food_bank_rounded,
                              color: Color(0xFF16c79e),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text('${recipe.servings}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
              child: Text('Bahan :',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // mainAxisExtent: 230,
              crossAxisCount: 2,
              childAspectRatio: 2.2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '- ${recipe.ingredient[index]}',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              childCount: recipe.ingredient.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
              child: Text('Cara Memasak :',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('${recipe.step[index]}',
                      textAlign: TextAlign.justify),
                );
              },
              childCount: recipe.step.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
              child: Text('Deskripsi :',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 30),
              child: Text(
                recipe.desc,
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
