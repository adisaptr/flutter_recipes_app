import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../data/models/recipe_detail_model.dart';
part 'recipe_detail.g.dart';

@HiveType(typeId: 0)
class RecipeDetail extends Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String thumb;
  @HiveField(2)
  final String servings;
  @HiveField(3)
  final String times;
  @HiveField(4)
  final String dificulty;
  @HiveField(5)
  final Author author;
  @HiveField(6)
  final String desc;
  @HiveField(7)
  final List<NeedItem> needItem;
  @HiveField(8)
  final List<String> ingredient;
  @HiveField(9)
  final List<String> step;

  const RecipeDetail(
      {required this.title,
      required this.thumb,
      required this.servings,
      required this.times,
      required this.dificulty,
      required this.author,
      required this.desc,
      required this.needItem,
      required this.ingredient,
      required this.step});

  @override
  List<Object?> get props => [
        title,
        thumb,
        servings,
        times,
        dificulty,
        author,
        desc,
        needItem,
        ingredient,
        step
      ];
}
