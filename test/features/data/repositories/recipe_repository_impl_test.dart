import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/exceptions.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/features/data/datasources/recipe_remote_data_source.dart';
import 'package:recipes_app/features/data/models/recipe_article_by_category_model.dart';
import 'package:recipes_app/features/data/models/recipe_article_category_model.dart';
import 'package:recipes_app/features/data/models/recipe_article_detail_model.dart';
import 'package:recipes_app/features/data/models/recipe_article_model.dart';
import 'package:recipes_app/features/data/models/recipe_by_search_model.dart';
import 'package:recipes_app/features/data/models/recipe_category_model.dart';
import 'package:recipes_app/features/data/models/recipe_detail_model.dart';
import 'package:recipes_app/features/data/models/recipe_model.dart';
import 'package:recipes_app/features/data/repositories/recipe_repository_impl.dart';
import 'package:recipes_app/features/domain/entities/recipe.dart';
import 'package:recipes_app/features/domain/entities/recipe_article.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_by_category.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_category.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_detail.dart';
import 'package:recipes_app/features/domain/entities/recipe_by_search.dart';
import 'package:recipes_app/features/domain/entities/recipe_category.dart';
import 'package:recipes_app/features/domain/entities/recipe_detail.dart';
import '../../../fixtures/fixture_reader.dart';
import 'recipe_repository_impl_test.mocks.dart';

@GenerateMocks([RecipeRemoteDataSource])
void main() {
  late RecipeRepositoryImpl repository;
  late MockRecipeRemoteDataSource mockRecipeRemoteDataSource;

  setUp(() {
    mockRecipeRemoteDataSource = MockRecipeRemoteDataSource();
    repository = RecipeRepositoryImpl(
        recipeRemoteDataSource: mockRecipeRemoteDataSource);
  });

  group('getRecipe RepositoryImpl', () {
    var dataResult = json.decode((fixture('recipe.json')))['results'] as List;
    final tRecipeModel =
        dataResult.map((tagJson) => RecipeModel.fromJson(tagJson)).toList();
    final List<Recipe> tRecipe = tRecipeModel;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipe())
          .thenAnswer((_) async => tRecipeModel);
      //act
      final result = await repository.getRecipe();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipe());
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipe()).thenThrow(ServerException());
      //act
      final result = await repository.getRecipe();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipe());
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeCategory RepositoryImpl', () {
    var dataResult =
        json.decode((fixture('recipeCategory.json')))['results'] as List;
    final tRecipeCategoryModel = dataResult
        .map((tagJson) => RecipeCategoryModel.fromJson(tagJson))
        .toList();
    final List<RecipeCategory> tRecipe = tRecipeCategoryModel;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeCategory())
          .thenAnswer((_) async => tRecipeCategoryModel);
      //act
      final result = await repository.getRecipeCategory();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeCategory());
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeCategory())
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeCategory();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeCategory());
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeArticle RepositoryImpl', () {
    var dataResult =
        json.decode((fixture('recipeArticle.json')))['results'] as List;
    final tRecipeArticleModel = dataResult
        .map((tagJson) => RecipeArticleModel.fromJson(tagJson))
        .toList();
    final List<RecipeArticle> tRecipe = tRecipeArticleModel;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticle())
          .thenAnswer((_) async => tRecipeArticleModel);
      //act
      final result = await repository.getRecipeArticle();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticle());
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticle())
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeArticle();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticle());
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeDetail RepositoryImpl', () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('recipeDetail.json'));
    final tRecipeDetailModel = RecipeDetailModel.fromJson(jsonMap['results']);
    final RecipeDetail tRecipe = tRecipeDetailModel;
    const tKey = "resep-bacem-tahu-tempe";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeDetail(any))
          .thenAnswer((_) async => tRecipeDetailModel);
      //act
      final result = await repository.getRecipeDetail(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeDetail(tKey));
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeDetail(any))
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeDetail(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeDetail(tKey));
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeByCategory RepositoryImpl', () {
    var dataResult = json.decode((fixture('recipe.json')))['results'] as List;
    final tRecipeModel =
        dataResult.map((tagJson) => RecipeModel.fromJson(tagJson)).toList();
    final List<Recipe> tRecipe = tRecipeModel;
    const tKey = "resep-ayam";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeByCategory(any))
          .thenAnswer((_) async => tRecipeModel);
      //act
      final result = await repository.getRecipeByCategory(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeByCategory(tKey));
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeByCategory(any))
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeByCategory(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeByCategory(tKey));
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeBySearch RepositoryImpl', () {
    var dataResult =
        json.decode((fixture('recipeBySearch.json')))['results'] as List;
    final tRecipeModel = dataResult
        .map((tagJson) => RecipeBySearchModel.fromJson(tagJson))
        .toList();
    final List<RecipeBySearch> tRecipe = tRecipeModel;
    const tKey = "ayam madu";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeBySearch(any))
          .thenAnswer((_) async => tRecipeModel);
      //act
      final result = await repository.getRecipeBySearch(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeBySearch(tKey));
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeBySearch(any))
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeBySearch(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeBySearch(tKey));
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeArticleByCategory RepositoryImpl', () {
    var dataResult = json
        .decode((fixture('recipeArticleByCategory.json')))['results'] as List;
    final tRecipeArticleByCategoryModel = dataResult
        .map((tagJson) => RecipeArticleByCategoryModel.fromJson(tagJson))
        .toList();
    final List<RecipeArticleByCategory> tRecipeArticleByCategory =
        tRecipeArticleByCategoryModel;
    const tKey = "inspirasi-dapur";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticleByCategory(any))
          .thenAnswer((_) async => tRecipeArticleByCategoryModel);
      //act
      final result = await repository.getRecipeArticleByCategory(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticleByCategory(tKey));
      expect(result, equals(Right(tRecipeArticleByCategory)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticleByCategory(any))
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeArticleByCategory(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticleByCategory(tKey));
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeArticleCategory RepositoryImpl', () {
    var dataResult =
        json.decode((fixture('recipeArticleCategory.json')))['results'] as List;
    final tRecipeArticleCategoryModel = dataResult
        .map((tagJson) => RecipeArticleCategoryModel.fromJson(tagJson))
        .toList();
    final List<RecipeArticleCategory> tRecipe = tRecipeArticleCategoryModel;
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticleCategory())
          .thenAnswer((_) async => tRecipeArticleCategoryModel);
      //act
      final result = await repository.getRecipeArticleCategory();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticleCategory());
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticleCategory())
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeArticleCategory();
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticleCategory());
      expect(result, equals(left(ServerFailure())));
    });
  });
  group('getRecipeArticleDetail RepositoryImpl', () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('recipeArticleDetail.json'));
    final tRecipeArticleDetailModel =
        RecipeArticleDetailModel.fromJson(jsonMap['results']);
    final RecipeArticleDetail tRecipe = tRecipeArticleDetailModel;
    const tKey = "makanan-gaya-hidup/makanan-khas-cirebon";
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticleDetail(any))
          .thenAnswer((_) async => tRecipeArticleDetailModel);
      //act
      final result = await repository.getRecipeArticleDetail(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticleDetail(tKey));
      expect(result, equals(Right(tRecipe)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockRecipeRemoteDataSource.getRecipeArticleDetail(any))
          .thenThrow(ServerException());
      //act
      final result = await repository.getRecipeArticleDetail(tKey);
      //assert
      verify(mockRecipeRemoteDataSource.getRecipeArticleDetail(tKey));
      expect(result, equals(left(ServerFailure())));
    });
  });
}
