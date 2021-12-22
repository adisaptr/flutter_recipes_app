import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe_article_category.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeArticleCategory
    implements UseCase<List<RecipeArticleCategory>, NoParam> {
  final RecipeRepository repository;

  GetRecipeArticleCategory(this.repository);
  @override
  Future<Either<Failure, List<RecipeArticleCategory>>> call(
      NoParam params) async {
    return await repository.getRecipeArticleCategory();
  }
}
