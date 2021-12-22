import '../../domain/entities/recipe_article_by_category.dart';

class RecipeArticleByCategoryModel extends RecipeArticleByCategory {
  const RecipeArticleByCategoryModel(
      {required String title,
      required String thumb,
      required String tags,
      required String key})
      : super(title: title, thumb: thumb, tags: tags, key: key);
  factory RecipeArticleByCategoryModel.fromJson(Map<String, dynamic> json) {
    return RecipeArticleByCategoryModel(
        title: json['title'],
        thumb: json['thumb'],
        tags: json['tags'],
        key: json['key']);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumb': thumb,
      'tags': tags,
      'key': key,
    };
  }
}
