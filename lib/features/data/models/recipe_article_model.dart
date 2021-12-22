import '../../domain/entities/recipe_article.dart';

class RecipeArticleModel extends RecipeArticle {
  const RecipeArticleModel(
      {required String title, required String url, required String key})
      : super(title: title, url: url, key: key);
  factory RecipeArticleModel.fromJson(Map<String, dynamic> json) {
    return RecipeArticleModel(
        title: json['title'], url: json['url'], key: json['key']);
  }
  Map<String, dynamic> toJson() {
    return {'title': title, 'url': url, 'key': key};
  }
}
