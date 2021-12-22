import '../../domain/entities/recipe_article_detail.dart';

class RecipeArticleDetailModel extends RecipeArticleDetail {
  const RecipeArticleDetailModel(
      {required String title,
      required String thumb,
      required String author,
      required String datePublished,
      required String description})
      : super(
            title: title,
            thumb: thumb,
            author: author,
            datePublished: datePublished,
            description: description);
  factory RecipeArticleDetailModel.fromJson(Map<String, dynamic> json) {
    return RecipeArticleDetailModel(
      title: json['title'],
      thumb: json['thumb'],
      author: json['author'],
      datePublished: json['date_published'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'thumb': thumb,
      'author': author,
      'date_published': datePublished,
      'description': description,
    };
  }
}
