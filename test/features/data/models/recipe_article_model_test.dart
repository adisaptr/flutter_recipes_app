import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/data/models/recipe_article_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_article.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tRecipeArticleModel = RecipeArticleModel(
      title: "Sambut Hari Pangan Sedunia",
      url: "https://www.masakapahariini.com/",
      key: "resep-lezat-anti-sisa");
  test('should be subclass of recipe article entity', () async {
    expect(tRecipeArticleModel, isA<RecipeArticle>());
  });
  group('formJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('recipeArticle.json'))['results'][0];
      //act
      final result = RecipeArticleModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tRecipeArticleModel));
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      //act
      final result = tRecipeArticleModel.toJson();
      //assert
      final expectedMap = {
        "title": "Sambut Hari Pangan Sedunia",
        "url": "https://www.masakapahariini.com/",
        "key": "resep-lezat-anti-sisa"
      };
      expect(result, expectedMap);
    });
  });
}
