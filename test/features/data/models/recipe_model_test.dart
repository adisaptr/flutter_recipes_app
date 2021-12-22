import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/data/models/recipe_model.dart';
import 'package:recipes_app/features/domain/entities/recipe.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tRecipeModel = RecipeModel(
      title: 'Resep Opor Ayam Putih',
      thumb: 'https://opor-ayam-putih-400x240.jpg',
      key: 'resep-opor-ayam-putih',
      times: '1jam',
      portion: '4 porsi',
      dificulty: 'mudah');
  test('should be subclass of recipe entity', () async {
    expect(tRecipeModel, isA<Recipe>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('recipe.json'))['results'][0];
      //act
      final result = RecipeModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tRecipeModel));
    });
  });
  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      //act
      final result = tRecipeModel.toJson();
      //assert
      final expectedMap = {
        "title": "Resep Opor Ayam Putih",
        "thumb": "https://opor-ayam-putih-400x240.jpg",
        "key": "resep-opor-ayam-putih",
        "times": "1jam",
        "portion": "4 porsi",
        "dificulty": "mudah"
      };
      expect(result, expectedMap);
    });
  });
}
