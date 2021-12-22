import '../../domain/entities/recipe_by_search.dart';

class RecipeBySearchModel extends RecipeBySearch {
  const RecipeBySearchModel(
      {required String title,
      required String thumb,
      required String key,
      required String times,
      required String serving,
      required String difficulty})
      : super(
            title: title,
            thumb: thumb,
            key: key,
            times: times,
            serving: serving,
            difficulty: difficulty);

  factory RecipeBySearchModel.fromJson(Map<String, dynamic> json) {
    return RecipeBySearchModel(
        title: json['title'],
        thumb: json['thumb'],
        key: json['key'],
        times: json['times'],
        serving: json['serving'],
        difficulty: json['difficulty']);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumb': thumb,
      'key': key,
      'times': times,
      'serving': serving,
      'difficulty': difficulty,
    };
  }
}
