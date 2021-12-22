import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/data/models/recipe_category_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_category.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tRecipeCategoryModel = RecipeCategoryModel(
      category: "Dessert",
      url: "https://www.masakapahariini.com/resep-masakan/resep-dessert/",
      key: "resep-dessert");

  test('should be subclass of recipe category entity', () async {
    expect(tRecipeCategoryModel, isA<RecipeCategory>());
  });

  group('formJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('recipeCategory.json'))['results'][0];
      //act
      final result = RecipeCategoryModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tRecipeCategoryModel));
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      //act
      final result = tRecipeCategoryModel.toJson();
      //assert
      final expectedMap = {
        "category": "Dessert",
        "url": "https://www.masakapahariini.com/resep-masakan/resep-dessert/",
        "key": "resep-dessert"
      };
      expect(result, expectedMap);
    });
  });
}
