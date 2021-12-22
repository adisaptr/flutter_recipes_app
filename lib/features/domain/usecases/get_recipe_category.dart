import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe_category.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeCategory implements UseCase<List<RecipeCategory>, NoParam> {
  final RecipeRepository repository;

  GetRecipeCategory(this.repository);

  @override
  Future<Either<Failure, List<RecipeCategory>>> call(NoParam params) async {
    return await repository.getRecipeCategory();
  }
}
