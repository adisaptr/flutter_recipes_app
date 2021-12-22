import '../../domain/entities/recipe_category.dart';

class RecipeCategoryModel extends RecipeCategory {
  const RecipeCategoryModel(
      {required String category, required String url, required String key})
      : super(category: category, url: url, key: key);

  factory RecipeCategoryModel.fromJson(Map<String, dynamic> json) {
    return RecipeCategoryModel(
        category: json['category'], url: json['url'], key: json['key']);
  }
  Map<String, dynamic> toJson() {
    return {'category': category, 'url': url, 'key': key};
  }
}
