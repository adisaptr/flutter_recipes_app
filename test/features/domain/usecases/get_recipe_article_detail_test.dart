import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_detail.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article_detail.dart';
import 'get_recipe_article_detail_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeArticleDetail usecase;
  late MockRecipeRepository mockRecipeRepository;

  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeArticleDetail(mockRecipeRepository);
  });

  final tRecipeArticleDetail = RecipeArticleDetail(
      title: "5 Resep Makanan Khas Cirebon untuk Kejutan Keluarga di Rumah",
      thumb:
          "https://www.masakapahariini.com/wp-content/uploads/2018/11/nasi-lengko-MAHI-5-1024x576.jpg",
      author: "Wina",
      datePublished: "September 21, 2021",
      description: "Apa");
  const tKey = "makanan-gaya-hidup/makanan-khas-cirebon";
  test('should get recipe article detail from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeArticleDetail(any))
        .thenAnswer((_) async => Right(tRecipeArticleDetail));
    //act
    final result = await usecase(Params(key: tKey));
    //assert
    expect(result, Right(tRecipeArticleDetail));
    verify(mockRecipeRepository.getRecipeArticleDetail(any));
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
