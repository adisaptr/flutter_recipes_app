import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/recipe_detail.dart';
import '../repositories/recipe_repository.dart';

class GetRecipeDetail implements UseCase<RecipeDetail, Params> {
  final RecipeRepository repository;

  GetRecipeDetail(this.repository);

  @override
  Future<Either<Failure, RecipeDetail>> call(Params params) async {
    return await repository.getRecipeDetail(params.key);
  }
}
