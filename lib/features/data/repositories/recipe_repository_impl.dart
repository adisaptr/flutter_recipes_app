import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/recipe_article.dart';
import '../../domain/entities/recipe_article_by_category.dart';
import '../../domain/entities/recipe_article_category.dart';
import '../../domain/entities/recipe_article_detail.dart';
import '../../domain/entities/recipe_by_search.dart';
import '../../domain/entities/recipe_category.dart';
import '../../domain/entities/recipe_detail.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource recipeRemoteDataSource;

  RecipeRepositoryImpl({required this.recipeRemoteDataSource});
  @override
  Future<Either<Failure, List<Recipe>>> getRecipe() async {
    try {
      final remoteRecipe = await recipeRemoteDataSource.getRecipe();
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeCategory>>> getRecipeCategory() async {
    try {
      final remoteRecipe = await recipeRemoteDataSource.getRecipeCategory();
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeArticle>>> getRecipeArticle() async {
    try {
      final remoteRecipe = await recipeRemoteDataSource.getRecipeArticle();
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String key) async {
    try {
      final remoteRecipe = await recipeRemoteDataSource.getRecipeDetail(key);
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipeByCategory(String key) async {
    try {
      final remoteRecipe =
          await recipeRemoteDataSource.getRecipeByCategory(key);
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeBySearch>>> getRecipeBySearch(
      String key) async {
    try {
      final remoteRecipe = await recipeRemoteDataSource.getRecipeBySearch(key);
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeArticleByCategory>>>
      getRecipeArticleByCategory(String key) async {
    try {
      final remoteRecipe =
          await recipeRemoteDataSource.getRecipeArticleByCategory(key);
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeArticleCategory>>>
      getRecipeArticleCategory() async {
    try {
      final remoteRecipe =
          await recipeRemoteDataSource.getRecipeArticleCategory();
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RecipeArticleDetail>> getRecipeArticleDetail(
      String key) async {
    try {
      final remoteRecipe =
          await recipeRemoteDataSource.getRecipeArticleDetail(key);
      return Right(remoteRecipe);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
