import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class GetRecipe implements UseCase<List<Recipe>, NoParam> {
  final RecipeRepository repository;

  GetRecipe(this.repository);

  @override
  Future<Either<Failure, List<Recipe>>> call(NoParam params) async {
    return await repository.getRecipe();
  }
}
