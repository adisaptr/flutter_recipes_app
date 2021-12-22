import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_category.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_category.dart';

import 'get_recipe_category_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeCategory usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeCategory(mockRecipeRepository);
  });

  final tRecipeCategory = [
    RecipeCategory(
        category: 'Dessert',
        url: 'https://www.masakapahariini.com/resep-masakan/resep-dessert/',
        key: 'resep-dessert')
  ];

  test('should get recipe category from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeCategory())
        .thenAnswer((_) async => Right(tRecipeCategory));
    //act
    final result = await usecase(NoParam());
    //assert
    expect(result, Right(tRecipeCategory));
    verify(mockRecipeRepository.getRecipeCategory());
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
