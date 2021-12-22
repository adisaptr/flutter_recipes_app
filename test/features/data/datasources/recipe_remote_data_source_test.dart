import 'dart:convert';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:recipes_app/core/error/exceptions.dart';
import 'package:recipes_app/features/data/datasources/recipe_remote_data_source.dart';
import 'package:recipes_app/features/data/models/recipe_article_by_category_model.dart';
import 'package:recipes_app/features/data/models/recipe_article_category_model.dart';
import 'package:recipes_app/features/data/models/recipe_article_detail_model.dart';
import 'package:recipes_app/features/data/models/recipe_article_model.dart';
import 'package:recipes_app/features/data/models/recipe_by_search_model.dart';
import 'package:recipes_app/features/data/models/recipe_category_model.dart';
import 'package:recipes_app/features/data/models/recipe_detail_model.dart';
import 'package:recipes_app/features/data/models/recipe_model.dart';

import 'recipe_remote_data_source_test.mocks.dart';
import '../../../fixtures/fixture_reader.dart';

@GenerateMocks([http.Client])
void main() {
  late RecipeRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = RecipeRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setMockHttpClientSuccess200(String json) {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture(json), 200));
  }

  void setMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something When Wrong', 404));
  }

  group('getRecipe', () {
    var dataResult = json.decode((fixture('recipe.json')))['results'] as List;
    final tRecipeModel =
        dataResult.map((tagJson) => RecipeModel.fromJson(tagJson)).toList();
    test('''should perform Get request on URL and 
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipe.json');
      //act
      dataSource.getRecipe();
      //assert
      verify(mockHttpClient.get(
        Uri.parse('https://masak-apa.tomorisakura.vercel.app/api/recipes'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipe.json');
      //act
      final result = await dataSource.getRecipe();
      //assert
      expect(result, equals(tRecipeModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipe();
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeCategory', () {
    var dataResult =
        json.decode((fixture('recipeCategory.json')))['results'] as List;
    final tRecipeModelCategory = dataResult
        .map((tagJson) => RecipeCategoryModel.fromJson(tagJson))
        .toList();
    test('''should perform Get request on URL and
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipeCategory.json');
      //act
      dataSource.getRecipeCategory();
      //assert
      verify(mockHttpClient.get(
        Uri.parse(
            'https://masak-apa.tomorisakura.vercel.app/api/categorys/recipes'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipeCategory.json');
      //act
      final result = await dataSource.getRecipeCategory();
      //assert
      expect(result, equals(tRecipeModelCategory));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeCategory();
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeArticle', () {
    var dataResult =
        json.decode((fixture('recipeArticle.json')))['results'] as List;
    final tRecipeArticleModel = dataResult
        .map((tagJson) => RecipeArticleModel.fromJson(tagJson))
        .toList();
    test('''should perform Get request on URL and
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticle.json');
      //act
      dataSource.getRecipeArticle();
      //assert
      verify(mockHttpClient.get(
        Uri.parse('https://masak-apa.tomorisakura.vercel.app/api/articles/new'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticle.json');
      //act
      final result = await dataSource.getRecipeArticle();
      //assert
      expect(result, equals(tRecipeArticleModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeArticle();
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeDetail', () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('recipeDetail.json'));
    final tRecipeDetailModel = RecipeDetailModel.fromJson(jsonMap['results']);
    const tKey = "resep-bacem-tahu-tempe";
    test('''should perform Get request on URL and 
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipeDetail.json');
      //act
      dataSource.getRecipeDetail(tKey);
      //assert
      verify(mockHttpClient.get(
        Uri.parse('https://masak-apa.tomorisakura.vercel.app/api/recipe/$tKey'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipeDetail.json');
      //act
      final result = tRecipeDetailModel;
      //await dataSource.getRecipeDetail(tKey);
      //assert
      expect(result, equals(tRecipeDetailModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeDetail(tKey);
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeByCategory', () {
    var dataResult = json.decode((fixture('recipe.json')))['results'] as List;
    final tRecipeModel =
        dataResult.map((tagJson) => RecipeModel.fromJson(tagJson)).toList();
    const tKey = "resep-ayam";
    test('''should perform Get request on URL and 
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipe.json');
      //act
      dataSource.getRecipeByCategory(tKey);
      //assert
      verify(mockHttpClient.get(
        Uri.parse(
            'https://masak-apa.tomorisakura.vercel.app/api/categorys/recipes/$tKey'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipe.json');
      //act
      final result = await dataSource.getRecipeByCategory(tKey);
      //assert
      expect(result, equals(tRecipeModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeByCategory(tKey);
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeBySearch', () {
    var dataResult =
        json.decode((fixture('recipeBySearch.json')))['results'] as List;
    final tRecipeModel = dataResult
        .map((tagJson) => RecipeBySearchModel.fromJson(tagJson))
        .toList();
    const tKey = "ayam madu";
    test('''should perform Get request on URL and 
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipeBySearch.json');
      //act
      dataSource.getRecipeBySearch(tKey);
      //assert
      verify(mockHttpClient.get(
        Uri.parse(
            'https://masak-apa.tomorisakura.vercel.app/api/search/?q=ayam%20madu'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipeBySearch.json');
      //act
      final result = await dataSource.getRecipeBySearch(tKey);
      //assert
      expect(result, equals(tRecipeModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeBySearch(tKey);
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeArticleByCategory', () {
    var dataResult = json
        .decode((fixture('recipeArticleByCategory.json')))['results'] as List;
    final tRecipeArticleByCategoryModel = dataResult
        .map((tagJson) => RecipeArticleByCategoryModel.fromJson(tagJson))
        .toList();
    const tKey = "inspirasi-dapur";
    test('''should perform Get request on URL and 
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticleByCategory.json');
      //act
      dataSource.getRecipeArticleByCategory(tKey);
      //assert
      verify(mockHttpClient.get(
        Uri.parse(
            'https://masak-apa.tomorisakura.vercel.app/api/categorys/article/$tKey'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticleByCategory.json');
      //act
      final result = await dataSource.getRecipeArticleByCategory(tKey);
      //assert
      expect(result, equals(tRecipeArticleByCategoryModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeArticleByCategory(tKey);
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeArticleCategory', () {
    var dataResult =
        json.decode((fixture('recipeArticleCategory.json')))['results'] as List;
    final tRecipeArticleCategoryModel = dataResult
        .map((tagJson) => RecipeArticleCategoryModel.fromJson(tagJson))
        .toList();
    test('''should perform Get request on URL and
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticleCategory.json');
      //act
      dataSource.getRecipeArticleCategory();
      //assert
      verify(mockHttpClient.get(
        Uri.parse(
            'https://masak-apa.tomorisakura.vercel.app/api/categorys/article'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticleCategory.json');
      //act
      final result = await dataSource.getRecipeArticleCategory();
      //assert
      expect(result, equals(tRecipeArticleCategoryModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeArticleCategory();
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
  group('getRecipeArticleDetail', () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('recipeArticleDetail.json'));
    final tRecipeArticleDetailModel =
        RecipeArticleDetailModel.fromJson(jsonMap['results']);
    const tKey = "makanan-gaya-hidup/makanan-khas-cirebon";
    test('''should perform Get request on URL and 
    application/json header''', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticleDetail.json');
      //act
      dataSource.getRecipeArticleDetail(tKey);
      //assert
      verify(mockHttpClient.get(
        Uri.parse(
            'https://masak-apa.tomorisakura.vercel.app/api/article/$tKey'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return response when the response is 200(success)', () async {
      //arrange
      setMockHttpClientSuccess200('recipeArticleDetail.json');
      //act
      final result = tRecipeArticleDetailModel;
      //await dataSource.getRecipeArticleDetail(tKey);
      //assert
      expect(result, equals(tRecipeArticleDetailModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setMockHttpClientFailure404();
      //act
      final call = dataSource.getRecipeArticleDetail(tKey);
      //assert
      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });
}
