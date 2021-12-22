import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'detail_favorite.dart';

class FavoriteRecipe extends StatefulWidget {
  const FavoriteRecipe({Key? key}) : super(key: key);

  @override
  _FavoriteRecipeState createState() => _FavoriteRecipeState();
}

class _FavoriteRecipeState extends State<FavoriteRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(
            color: Color(0xFF109173),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: FutureBuilder(
        future: Hive.openBox('favorite'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            } else {
              var favorite = Hive.box('favorite');
              if (favorite.length == 0) {
                return Center(
                  child: Text('Tidak ada favorite'),
                );
              } else {
                return ValueListenableBuilder(
                  valueListenable: favorite.listenable(),
                  builder: (BuildContext context, Box<dynamic> value,
                      Widget? child) {
                    return ListView.builder(
                        itemCount: favorite.length,
                        itemBuilder: (context, index) {
                          final data = favorite.getAt(index);
                          return Slidable(
                            key: ValueKey(0),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext context) {
                                    favorite.deleteAt(index);
                                  },
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Hapus',
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListTile(
                                leading: Container(
                                    color: Colors.grey[200],
                                    height: 100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        data.thumb,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                title: Text(
                                  data.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          DetailFavorite(recipe: data),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        });
                  },
                );
              }
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

void doNothing(BuildContext context) {}
