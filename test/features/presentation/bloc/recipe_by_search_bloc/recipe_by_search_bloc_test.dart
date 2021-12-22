import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_by_search.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_by_search.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_by_search_bloc/bloc/recipe_by_search_bloc.dart';
import 'recipe_by_search_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeBySearch])
void main() {
  late RecipeBySearchBloc bloc;
  late MockGetRecipeBySearch mockGetRecipeBySearch;
  setUp(() {
    mockGetRecipeBySearch = MockGetRecipeBySearch();
    bloc = RecipeBySearchBloc(getRecipeBySearch: mockGetRecipeBySearch);
  });

  group('GetRecipeBySearchBloc', () {
    final tRecipe = [
      RecipeBySearch(
          title: 'Resep Opor Ayam Putih',
          thumb: 'https://opor-ayam-putih-400x240.jpg',
          key: 'resep-opor-ayam-putih',
          times: '1jam',
          serving: '4 porsi',
          difficulty: 'mudah')
    ];
    const tKey = "resep ayam";

    test('should get data from the recipe search use case', () async {
      //arrange
      when(mockGetRecipeBySearch(any)).thenAnswer((_) async => Right(tRecipe));
      //act
      bloc.add(GetDataForRecipeSearch(tKey));
      await untilCalled(mockGetRecipeBySearch(any));
      //assert
      verify(mockGetRecipeBySearch(Params(key: tKey)));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipeBySearch(any)).thenAnswer((_) async => Right(tRecipe));
      //assert later
      final expected = [Loading(), Loaded(recipe: tRecipe)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeSearch(tKey));
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipeBySearch(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeSearch(tKey));
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipeBySearch(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeSearch(tKey));
    });
  });
}
