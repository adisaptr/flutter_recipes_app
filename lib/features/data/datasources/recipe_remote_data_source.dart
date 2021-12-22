import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/error/exceptions.dart';
import '../models/recipe_article_by_category_model.dart';
import '../models/recipe_article_category_model.dart';
import '../models/recipe_article_detail_model.dart';
import '../models/recipe_article_model.dart';
import '../models/recipe_by_search_model.dart';
import '../models/recipe_category_model.dart';
import '../models/recipe_detail_model.dart';
import '../models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRecipe();
  Future<List<RecipeCategoryModel>> getRecipeCategory();
  Future<List<RecipeModel>> getRecipeByCategory(String key);
  Future<List<RecipeBySearchModel>> getRecipeBySearch(String key);
  Future<List<RecipeArticleModel>> getRecipeArticle();
  Future<RecipeDetailModel> getRecipeDetail(String key);
  Future<List<RecipeArticleCategoryModel>> getRecipeArticleCategory();
  Future<List<RecipeArticleByCategoryModel>> getRecipeArticleByCategory(
      String key);
  Future<RecipeArticleDetailModel> getRecipeArticleDetail(String key);
}

class RecipeRemoteDataSourceImpl extends RecipeRemoteDataSource {
  final http.Client client;
  String baseUrl = 'https://masak-apa.tomorisakura.vercel.app/api/';

  RecipeRemoteDataSourceImpl({required this.client});
  @override
  Future<List<RecipeModel>> getRecipe() async {
    String url = baseUrl + 'recipes';
    print('masuk get recipe');
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body)['results'] as List;
      List<RecipeModel> recipe =
          dataResult.map((tagJson) => RecipeModel.fromJson(tagJson)).toList();
      return recipe;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeCategoryModel>> getRecipeCategory() async {
    String url = baseUrl + 'categorys/recipes';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body)['results'] as List;
      List<RecipeCategoryModel> recipe = dataResult
          .map((tagJson) => RecipeCategoryModel.fromJson(tagJson))
          .toList();
      return recipe;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeArticleModel>> getRecipeArticle() async {
    String url = baseUrl + 'articles/new';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body)['results'] as List;
      List<RecipeArticleModel> recipe = dataResult
          .map((tagJson) => RecipeArticleModel.fromJson(tagJson))
          .toList();
      return recipe;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RecipeDetailModel> getRecipeDetail(String key) async {
    String url = baseUrl + 'recipe/' + key;
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body);
      return RecipeDetailModel.fromJson(dataResult['results']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeModel>> getRecipeByCategory(String key) async {
    String url = baseUrl + 'categorys/recipes/' + key;
    print('masuk get recipe by category');
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body)['results'] as List;
      List<RecipeModel> recipe =
          dataResult.map((tagJson) => RecipeModel.fromJson(tagJson)).toList();
      return recipe;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeBySearchModel>> getRecipeBySearch(String key) async {
    String url = baseUrl + 'search/?q=' + key;
    print('masuk get recipe by search ' + url);
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body)['results'] as List;
      List<RecipeBySearchModel> recipe = dataResult
          .map((tagJson) => RecipeBySearchModel.fromJson(tagJson))
          .toList();
      return recipe;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeArticleByCategoryModel>> getRecipeArticleByCategory(
      String key) async {
    String url = baseUrl + 'categorys/article/' + key;
    print('masuk get recipe by category');
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body)['results'] as List;
      List<RecipeArticleByCategoryModel> recipe = dataResult
          .map((tagJson) => RecipeArticleByCategoryModel.fromJson(tagJson))
          .toList();
      return recipe;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<RecipeArticleCategoryModel>> getRecipeArticleCategory() async {
    String url = baseUrl + 'categorys/article';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body)['results'] as List;
      List<RecipeArticleCategoryModel> recipe = dataResult
          .map((tagJson) => RecipeArticleCategoryModel.fromJson(tagJson))
          .toList();
      return recipe;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RecipeArticleDetailModel> getRecipeArticleDetail(String key) async {
    String url = baseUrl + 'article/' + key;
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    var body = response.body;
    print('response $body');
    if (response.statusCode == 200) {
      var dataResult = json.decode(response.body);
      return RecipeArticleDetailModel.fromJson(dataResult['results']);
    } else {
      throw ServerException();
    }
  }
}
