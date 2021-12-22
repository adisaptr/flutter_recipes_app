import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeByCategory implements UseCase<List<Recipe>, Params> {
  final RecipeRepository repository;

  GetRecipeByCategory(this.repository);

  @override
  Future<Either<Failure, List<Recipe>>> call(Params params) async {
    return await repository.getRecipeByCategory(params.key);
  }
}
