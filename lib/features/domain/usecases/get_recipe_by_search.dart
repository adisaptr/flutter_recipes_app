import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe_by_search.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeBySearch implements UseCase<List<RecipeBySearch>, Params> {
  final RecipeRepository repository;

  GetRecipeBySearch(this.repository);

  @override
  Future<Either<Failure, List<RecipeBySearch>>> call(Params params) async {
    return await repository.getRecipeBySearch(params.key);
  }
}
