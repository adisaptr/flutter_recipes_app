import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_by_category.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article_by_category.dart';
import 'get_recipe_article_by_category_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeArticleByCategory usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeArticleByCategory(mockRecipeRepository);
  });

  final tRecipeArticleByCategory = [
    RecipeArticleByCategory(
        title: "5 Cara Kamu Bisa Mencegah Food Waste dari Rumah Sendiri",
        thumb:
            "https://www.masakapahariini.com/wp-content/uploads/2021/04/food-waste-400x240.jpg",
        tags: "Inspirasi Dapur",
        key: "cara-mencegah-food-waste")
  ];
  const tKey = "inspirasi-dapur";
  test('should get recipe article by category from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeArticleByCategory(any))
        .thenAnswer((_) async => Right(tRecipeArticleByCategory));
    //act
    final result = await usecase(Params(key: tKey));
    //assert
    expect(result, Right(tRecipeArticleByCategory));
    verify(mockRecipeRepository.getRecipeArticleByCategory(any));
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
