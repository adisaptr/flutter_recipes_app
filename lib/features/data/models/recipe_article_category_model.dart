import '../../domain/entities/recipe_article_category.dart';

class RecipeArticleCategoryModel extends RecipeArticleCategory {
  const RecipeArticleCategoryModel({required String title, required String key})
      : super(title: title, key: key);

  factory RecipeArticleCategoryModel.fromJson(Map<String, dynamic> json) {
    return RecipeArticleCategoryModel(title: json['title'], key: json['key']);
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'key': key,
    };
  }
}
