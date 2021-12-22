import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_by_category.dart';
import 'get_recipe_by_category_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeByCategory usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeByCategory(mockRecipeRepository);
  });
  final tRecipe = [
    Recipe(
        title: 'Resep Opor Ayam Putih',
        thumb: 'https://opor-ayam-putih-400x240.jpg',
        key: 'resep-opor-ayam-putih',
        times: '1jam',
        portion: '4 porsi',
        dificulty: 'mudah')
  ];
  const tKey = "resep-ayam";

  test('should get recipe by category from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeByCategory(any))
        .thenAnswer((_) async => Right(tRecipe));
    //act
    final result = await usecase(Params(key: tKey));
    //assert
    expect(result, Right(tRecipe));
    verify(mockRecipeRepository.getRecipeByCategory(tKey));
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
