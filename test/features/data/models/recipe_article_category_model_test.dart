import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/data/models/recipe_article_category_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_category.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tRecipeArticleCategoryModel = RecipeArticleCategoryModel(
      title: "Inspirasi Dapur", key: "inspirasi-dapur");
  test('should be subclass of recipe article by category entity', () async {
    expect(tRecipeArticleCategoryModel, isA<RecipeArticleCategory>());
  });
  group('formJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('recipeArticleCategory.json'))['results'][0];
      //act
      final result = RecipeArticleCategoryModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tRecipeArticleCategoryModel));
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      //act
      final result = tRecipeArticleCategoryModel.toJson();
      //assert
      final expectedMap = {
        "title": "Inspirasi Dapur",
        "key": "inspirasi-dapur"
      };
      expect(result, expectedMap);
    });
  });
}
