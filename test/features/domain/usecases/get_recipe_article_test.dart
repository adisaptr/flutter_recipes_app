import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article.dart';

import 'get_recipe_article_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeArticle usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeArticle(mockRecipeRepository);
  });

  final tRecipeArticle = [
    RecipeArticle(
        title: "Sambut Hari Pangan Sedunia",
        url: "https://www.masakapahariini.com/",
        key: "resep-lezat-anti-sisa")
  ];
  test('should get recipe article from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeArticle())
        .thenAnswer((_) async => Right(tRecipeArticle));
    //act
    final result = await usecase(NoParam());
    //assert
    expect(result, Right(tRecipeArticle));
    verify(mockRecipeRepository.getRecipeArticle());
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
