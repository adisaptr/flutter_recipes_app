import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_by_search.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_by_search.dart';
import 'get_recipe_by_search_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeBySearch usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeBySearch(mockRecipeRepository);
  });
  final tRecipe = [
    RecipeBySearch(
        title: 'Resep Opor Ayam Putih',
        thumb: 'https://opor-ayam-putih-400x240.jpg',
        key: 'resep-opor-ayam-putih',
        times: '1jam',
        serving: '4 porsi',
        difficulty: 'mudah')
  ];
  const tKey = "resep-ayam";

  test('should get recipe by search from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeBySearch(any))
        .thenAnswer((_) async => Right(tRecipe));
    //act
    final result = await usecase(Params(key: tKey));
    //assert
    expect(result, Right(tRecipe));
    verify(mockRecipeRepository.getRecipeBySearch(tKey));
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
