import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_category.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article_category.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_article_category_bloc/bloc/recipe_article_category_bloc.dart';
import 'recipe_article_category_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeArticleCategory])
void main() {
  late RecipeArticleCategoryBloc bloc;
  late MockGetRecipeArticleCategory mockGetRecipeArticleCategory;
  setUp(() {
    mockGetRecipeArticleCategory = MockGetRecipeArticleCategory();
    bloc = RecipeArticleCategoryBloc(
        getRecipeArticleCategory: mockGetRecipeArticleCategory);
  });

  group('GetRecipeArticleCategoryBloc', () {
    final tRecipeArticleCategory = [
      RecipeArticleCategory(title: "Inspirasi Dapur", key: "inspirasi-dapur")
    ];

    test('should get data from the recipe article category use case', () async {
      //arrange
      when(mockGetRecipeArticleCategory(any))
          .thenAnswer((_) async => Right(tRecipeArticleCategory));
      //act
      bloc.add(GetDataForRecipeArticleCategory());
      await untilCalled(mockGetRecipeArticleCategory(any));
      //assert
      verify(mockGetRecipeArticleCategory(NoParam()));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipeArticleCategory(any))
          .thenAnswer((_) async => Right(tRecipeArticleCategory));
      //assert later
      final expected = [Loading(), Loaded(category: tRecipeArticleCategory)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleCategory());
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipeArticleCategory(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleCategory());
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipeArticleCategory(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleCategory());
    });
  });
}
