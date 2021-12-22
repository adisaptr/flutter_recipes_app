import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe_article_detail.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeArticleDetail implements UseCase<RecipeArticleDetail, Params> {
  final RecipeRepository repository;

  GetRecipeArticleDetail(this.repository);

  @override
  Future<Either<Failure, RecipeArticleDetail>> call(Params params) async {
    return await repository.getRecipeArticleDetail(params.key);
  }
}
