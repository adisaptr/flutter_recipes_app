import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe_article_by_category.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeArticleByCategory
    implements UseCase<List<RecipeArticleByCategory>, Params> {
  final RecipeRepository repository;

  GetRecipeArticleByCategory(this.repository);
  @override
  Future<Either<Failure, List<RecipeArticleByCategory>>> call(
      Params params) async {
    return await repository.getRecipeArticleByCategory(params.key);
  }
}
