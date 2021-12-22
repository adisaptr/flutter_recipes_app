import '../../domain/entities/recipe_detail.dart';
import 'package:hive/hive.dart';
part 'recipe_detail_model.g.dart';

class RecipeDetailModel extends RecipeDetail {
  const RecipeDetailModel(
      {required String title,
      required String thumb,
      required String servings,
      required String times,
      required String dificulty,
      required Author author,
      required String desc,
      required List<NeedItem> needItem,
      required List<String> ingredient,
      required List<String> step})
      : super(
            title: title,
            thumb: thumb,
            servings: servings,
            times: times,
            dificulty: dificulty,
            author: author,
            desc: desc,
            needItem: needItem,
            ingredient: ingredient,
            step: step);
  factory RecipeDetailModel.fromJson(Map<String, dynamic> json) {
    return RecipeDetailModel(
        title: json['title'],
        thumb: json['thumb'],
        servings: json['servings'],
        times: json['times'],
        dificulty: json['dificulty'],
        author: Author.fromJson(json['author']),
        desc: json['desc'],
        needItem: List<NeedItem>.from(
            json["needItem"].map((x) => NeedItem.fromJson(x))),
        ingredient: List.from(json['ingredient']),
        step: List.from(json['step']));
  }
}

@HiveType(typeId: 1)
class Author {
  @HiveField(0)
  final String user;
  @HiveField(1)
  final String datePublished;

  Author({required this.user, required this.datePublished});
  factory Author.fromJson(dynamic json) {
    return Author(user: json['user'], datePublished: json['datePublished']);
  }
}

@HiveType(typeId: 2)
class NeedItem {
  @HiveField(0)
  final String itemName;
  @HiveField(1)
  final String thumbItem;

  NeedItem({required this.itemName, required this.thumbItem});
  factory NeedItem.fromJson(Map<String, dynamic> json) {
    return NeedItem(itemName: json['item_name'], thumbItem: json['thumb_item']);
  }
}
