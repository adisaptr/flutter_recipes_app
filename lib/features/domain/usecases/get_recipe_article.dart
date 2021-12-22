import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe_article.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeArticle implements UseCase<List<RecipeArticle>, NoParam> {
  final RecipeRepository repository;

  GetRecipeArticle(this.repository);

  @override
  Future<Either<Failure, List<RecipeArticle>>> call(NoParam params) async {
    return await repository.getRecipeArticle();
  }
}
