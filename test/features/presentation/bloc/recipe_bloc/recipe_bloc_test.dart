import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_bloc/bloc/recipe_bloc.dart';
import 'recipe_bloc_test.mocks.dart';

@GenerateMocks([GetRecipe])
void main() {
  late RecipeBloc bloc;
  late MockGetRecipe mockGetRecipe;

  setUp(() {
    mockGetRecipe = MockGetRecipe();
    bloc = RecipeBloc(getRecipe: mockGetRecipe);
  });

  group('GetRecipeBloc', () {
    final tRecipe = [
      Recipe(
          title: 'Resep Opor Ayam Putih',
          thumb: 'https://opor-ayam-putih-400x240.jpg',
          key: 'resep-opor-ayam-putih',
          times: '1jam',
          portion: '4 porsi',
          dificulty: 'mudah')
    ];

    test('should get data from the recipe use case', () async {
      //arrange
      when(mockGetRecipe(any)).thenAnswer((_) async => Right(tRecipe));
      //act
      bloc.add(GetDataForRecipe());
      await untilCalled(mockGetRecipe(any));
      //assert
      verify(mockGetRecipe(NoParam()));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipe(any)).thenAnswer((_) async => Right(tRecipe));
      //assert later
      final expected = [Loading(), Loaded(recipe: tRecipe)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipe());
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipe(any)).thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipe());
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipe(any)).thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipe());
    });
  });
}
