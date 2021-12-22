import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipes_app/features/data/models/recipe_article_detail_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_detail.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tRecipeArticleDetailModel = RecipeArticleDetailModel(
      title: "5 Resep Makanan Khas Cirebon untuk Kejutan Keluarga di Rumah",
      thumb:
          "https://www.masakapahariini.com/wp-content/uploads/2018/11/nasi-lengko-MAHI-5-1024x576.jpg",
      author: "Wina",
      datePublished: "September 21, 2021",
      description: "Apa");
  test('should be subclass of recipe article detail entity', () async {
    expect(tRecipeArticleDetailModel, isA<RecipeArticleDetail>());
  });
  group('formJson', () {
    test('should return a valid model', () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('recipeArticleDetail.json'))['results'];
      //act
      final result = RecipeArticleDetailModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tRecipeArticleDetailModel));
    });
  });

  group('toJson', () {
    test('should return a Json map containing the proper data', () async {
      //act
      final result = tRecipeArticleDetailModel.toJson();
      //assert
      final expectedMap = {
        "title": "5 Resep Makanan Khas Cirebon untuk Kejutan Keluarga di Rumah",
        "thumb":
            "https://www.masakapahariini.com/wp-content/uploads/2018/11/nasi-lengko-MAHI-5-1024x576.jpg",
        "author": "Wina",
        "date_published": "September 21, 2021",
        "description": "Apa"
      };
      expect(result, expectedMap);
    });
  });
}
