import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_detail.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article_detail.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_article_detail_bloc/bloc/recipe_article_detail_bloc.dart';
import 'recipe_article_detail_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeArticleDetail])
void main() {
  late RecipeArticleDetailBloc bloc;
  late MockGetRecipeArticleDetail mockGetRecipeArticleDetail;
  setUp(() {
    mockGetRecipeArticleDetail = MockGetRecipeArticleDetail();
    bloc = RecipeArticleDetailBloc(
        getRecipeArticleDetail: mockGetRecipeArticleDetail);
  });

  group('GetRecipeArticleDetailBloc', () {
    final tRecipeArticleDetail = RecipeArticleDetail(
        title: "5 Resep Makanan Khas Cirebon untuk Kejutan Keluarga di Rumah",
        thumb:
            "https://www.masakapahariini.com/wp-content/uploads/2018/11/nasi-lengko-MAHI-5-1024x576.jpg",
        author: "Wina",
        datePublished: "September 21, 2021",
        description: "Apa");
    const tKey = "makanan-gaya-hidup/makanan-khas-cirebon";

    test('should get data from the recipe use case', () async {
      //arrange
      when(mockGetRecipeArticleDetail(any))
          .thenAnswer((_) async => Right(tRecipeArticleDetail));
      //act
      bloc.add(GetDataForRecipeArticleDetail(tKey));
      await untilCalled(mockGetRecipeArticleDetail(any));
      //assert
      verify(mockGetRecipeArticleDetail(Params(key: tKey)));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipeArticleDetail(any))
          .thenAnswer((_) async => Right(tRecipeArticleDetail));
      //assert later
      final expected = [Loading(), Loaded(article: tRecipeArticleDetail)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleDetail(tKey));
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipeArticleDetail(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleDetail(tKey));
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipeArticleDetail(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeArticleDetail(tKey));
    });
  });
}
