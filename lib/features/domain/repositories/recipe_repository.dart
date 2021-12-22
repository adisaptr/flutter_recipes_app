import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/recipe.dart';
import '../entities/recipe_article.dart';
import '../entities/recipe_article_by_category.dart';
import '../entities/recipe_article_category.dart';
import '../entities/recipe_article_detail.dart';
import '../entities/recipe_by_search.dart';
import '../entities/recipe_category.dart';
import '../entities/recipe_detail.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRecipe();
  Future<Either<Failure, List<RecipeCategory>>> getRecipeCategory();
  Future<Either<Failure, List<Recipe>>> getRecipeByCategory(String key);
  Future<Either<Failure, List<RecipeBySearch>>> getRecipeBySearch(String key);
  Future<Either<Failure, List<RecipeArticle>>> getRecipeArticle();
  Future<Either<Failure, RecipeDetail>> getRecipeDetail(String key);
  Future<Either<Failure, List<RecipeArticleCategory>>>
      getRecipeArticleCategory();
  Future<Either<Failure, List<RecipeArticleByCategory>>>
      getRecipeArticleByCategory(String key);
  Future<Either<Failure, RecipeArticleDetail>> getRecipeArticleDetail(
      String key);
}
