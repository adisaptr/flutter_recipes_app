import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_category.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_category.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_category_bloc/bloc/recipe_category_bloc.dart';
import 'recipe_category_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeCategory])
void main() {
  late RecipeCategoryBloc bloc;
  late MockGetRecipeCategory mockGetRecipeCategory;
  setUp(() {
    mockGetRecipeCategory = MockGetRecipeCategory();
    bloc = RecipeCategoryBloc(getRecipeCategory: mockGetRecipeCategory);
  });

  group('GetRecipeCategoryBloc', () {
    final tRecipeCategory = [
      RecipeCategory(
          category: 'Dessert',
          url: 'https://www.masakapahariini.com/resep-masakan/resep-dessert/',
          key: 'resep-dessert')
    ];

    test('should get data from the recipe use case', () async {
      //arrange
      when(mockGetRecipeCategory(any))
          .thenAnswer((_) async => Right(tRecipeCategory));
      //act
      bloc.add(GetDataForRecipeCategory());
      await untilCalled(mockGetRecipeCategory(any));
      //assert
      verify(mockGetRecipeCategory(NoParam()));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipeCategory(any))
          .thenAnswer((_) async => Right(tRecipeCategory));
      //assert later
      final expected = [Loading(), Loaded(category: tRecipeCategory)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeCategory());
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipeCategory(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeCategory());
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipeCategory(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeCategory());
    });
  });
}
