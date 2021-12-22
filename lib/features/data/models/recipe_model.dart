import '../../domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  const RecipeModel(
      {required String title,
      required String thumb,
      required String key,
      required String times,
      required String portion,
      required String dificulty})
      : super(
            title: title,
            thumb: thumb,
            key: key,
            times: times,
            portion: portion,
            dificulty: dificulty);

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        title: json['title'],
        thumb: json['thumb'],
        key: json['key'],
        times: json['times'],
        portion: json['portion'],
        dificulty: json['dificulty']);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumb': thumb,
      'key': key,
      'times': times,
      'portion': portion,
      'dificulty': dificulty,
    };
  }
}
