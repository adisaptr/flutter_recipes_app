import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_by_category.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article_by_category.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_article_by_category_bloc/bloc/recipe_article_by_category_bloc.dart';
import 'recipe_article_by_category_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeArticleByCategory])
void main() {
  late RecipeArticleByCategoryBloc bloc;
  late MockGetRecipeArticleByCategory mockGetRecipeArticleByCategory;
  setUp(() {
    mockGetRecipeArticleByCategory = MockGetRecipeArticleByCategory();
    bloc = RecipeArticleByCategoryBloc(
        getRecipeArticleByCategory: mockGetRecipeArticleByCategory);
  });

  group('GetRecipeArticleByCategoryBloc', () {
    final tRecipeArticleByCategory = [
      RecipeArticleByCategory(
          title: "5 Cara Kamu Bisa Mencegah Food Waste dari Rumah Sendiri",
          thumb:
              "https://www.masakapahariini.com/wp-content/uploads/2021/04/food-waste-400x240.jpg",
          tags: "Inspirasi Dapur",
          key: "cara-mencegah-food-waste")
    ];
    const tKey = "inspirasi-dapur";

    test('should get data from the recipe article use case', () async {
      //arrange
      when(mockGetRecipeArticleByCategory(any))
          .thenAnswer((_) async => Right(tRecipeArticleByCategory));
      //act
      bloc.add(GetDataForRecipeArticleList(tKey));
      await untilCalled(mockGetRecipeArticleByCategory(any));
      //assert
      verify(mockGetRecipeArticleByCategory(Params(key: tKey)));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipeArticleByCategory(any))
          .thenAnswer((_) async => Right(tRecipeArticleByCategory));
      //assert later
      final expected = [Loading(), Loaded(article: tRecipeArticleByCategory)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleList(tKey));
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipeArticleByCategory(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleList(tKey));
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipeArticleByCategory(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleList(tKey));
    });
  });
}
