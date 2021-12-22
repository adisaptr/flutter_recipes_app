import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_article_bloc/bloc/recipe_article_bloc.dart';
import 'recipe_article_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeArticle])
void main() {
  late RecipeArticleBloc bloc;
  late MockGetRecipeArticle mockGetRecipeArticle;
  setUp(() {
    mockGetRecipeArticle = MockGetRecipeArticle();
    bloc = RecipeArticleBloc(getRecipeArticle: mockGetRecipeArticle);
  });

  group('GetRecipeArticleBloc', () {
    final tRecipeArticle = [
      RecipeArticle(
          title: "Sambut Hari Pangan Sedunia",
          url: "https://www.masakapahariini.com/",
          key: "resep-lezat-anti-sisa")
    ];

    test('should get data from the recipe use case', () async {
      //arrange
      when(mockGetRecipeArticle(any))
          .thenAnswer((_) async => Right(tRecipeArticle));
      //act
      bloc.add(GetDataForRecipeArticle());
      await untilCalled(mockGetRecipeArticle(any));
      //assert
      verify(mockGetRecipeArticle(NoParam()));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipeArticle(any))
          .thenAnswer((_) async => Right(tRecipeArticle));
      //assert later
      final expected = [Loading(), Loaded(article: tRecipeArticle)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticle());
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipeArticle(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticle());
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipeArticle(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticle());
    });
  });
}
