import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/data/models/recipe_article_by_category_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_by_category.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tRecipeArticleByCategoryModel = RecipeArticleByCategoryModel(
      title: "5 Cara Kamu Bisa Mencegah Food Waste dari Rumah Sendiri",
      thumb:
          "https://www.masakapahariini.com/wp-content/uploads/2021/04/food-waste-400x240.jpg",
      tags: "Inspirasi Dapur",
      key: "cara-mencegah-food-waste");
  test('should be subclass of recipe article by category entity', () async {
    expect(tRecipeArticleByCategoryModel, isA<RecipeArticleByCategory>());
  });
  group('formJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('recipeArticleByCategory.json'))['results'][0];
      //act
      final result = RecipeArticleByCategoryModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tRecipeArticleByCategoryModel));
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      //act
      final result = tRecipeArticleByCategoryModel.toJson();
      //assert
      final expectedMap = {
        "title": "5 Cara Kamu Bisa Mencegah Food Waste dari Rumah Sendiri",
        "thumb":
            "https://www.masakapahariini.com/wp-content/uploads/2021/04/food-waste-400x240.jpg",
        "tags": "Inspirasi Dapur",
        "key": "cara-mencegah-food-waste"
      };
      expect(result, expectedMap);
    });
  });
}
