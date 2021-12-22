import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/data/models/recipe_detail_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_detail.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final Map<String, dynamic> jsonMap =
      json.decode(fixture('recipeDetail.json'));
  final tRecipeDetailModel = RecipeDetailModel.fromJson(jsonMap['results']);
  test('should be subclass of recipe detail entity', () async {
    expect(tRecipeDetailModel, isA<RecipeDetail>());
  });
  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      // final Map<String, dynamic> jsonMap =
      //     json.decode(fixture('recipeDetail.json'));
      //act
      final result = tRecipeDetailModel;
      //assert
      expect(result, equals(tRecipeDetailModel));
    });
  });
}
