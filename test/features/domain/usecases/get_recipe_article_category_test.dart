import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_category.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article_category.dart';
import 'get_recipe_article_category_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeArticleCategory usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeArticleCategory(mockRecipeRepository);
  });

  final tRecipeArticleCategory = [
    RecipeArticleCategory(title: "Inspirasi Dapur", key: "inspirasi-dapur")
  ];
  test('should get recipe article category from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeArticleCategory())
        .thenAnswer((_) async => Right(tRecipeArticleCategory));
    //act
    final result = await usecase(NoParam());
    //assert
    expect(result, Right(tRecipeArticleCategory));
    verify(mockRecipeRepository.getRecipeArticleCategory());
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
