import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/data/models/recipe_detail_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_detail.dart';
import 'package:recipes_app/features/domain/usecases/get_detail.dart';
import 'package:recipes_app/features/presentation/bloc/recipe_detail_bloc/bloc/recipe_detail_bloc.dart';
import 'recipe_detail_bloc_test.mocks.dart';

@GenerateMocks([GetRecipeDetail])
void main() {
  late RecipeDetailBloc bloc;
  late MockGetRecipeDetail mockGetRecipeDetail;
  setUp(() {
    mockGetRecipeDetail = MockGetRecipeDetail();
    bloc = RecipeDetailBloc(getRecipeDetail: mockGetRecipeDetail);
  });

  group('GetRecipeDetailBloc', () {
    final tRecipeDetail = RecipeDetail(
        title:
            "Resep Bacem Tahu Tempe, Kenikmatan Hakiki dari Sebuah Kesederhanaan",
        thumb:
            "https://www.masakapahariini.com/wp-content/uploads/2019/01/bacem-tahu-tempe-780x440.jpg",
        servings: "4 Porsi",
        times: "30mnt",
        dificulty: "Mudah",
        author: Author(user: "Maddie", datePublished: "Januari 10, 2019"),
        desc: "Sulit",
        needItem: [
          NeedItem(
              itemName: "Bango Bumbu Tempe & Tahu Bacem",
              thumbItem:
                  "https://www.masakapahariini.com/wp-content/uploads/2018/04/^740094ABA094B47189BD86C1C03F5A59452AA6DDCD7EA724F7^pimgpsh_fullsize_distr-100x100.png"),
        ],
        ingredient: const [
          "1 papan tempe atau kotak tahu, potong-potong",
          "300 ml air",
          "1 bungkus Bango Bumbu Tempe & Tahu Bacem"
        ],
        step: const [
          "1 Campurkan 1 papan tempe/ 1 kotak tahu yang sudah dipotong-potong dengan 1 bungkus Bango Bumbu Tempe & Tahu Bacem dan tambahkan 300 ml air.",
          "2 Ungkep hingga matang dan air surut. Bila kurang matang tambahkan air dan ungkep lagi sampai air habis.",
          "3 Goreng tempe/ tahu yang sudah diungkep dengan api sedang agar tidak gosong sampai berwarna kecoklatan. Angkat.",
          "4 Sajikan dengan pelengkapnya berupa bawang merah goreng."
        ]);
    const tKey = "resep-bacem-tahu-tempe";

    test('should get data from the recipe use case', () async {
      //arrange
      when(mockGetRecipeDetail(any))
          .thenAnswer((_) async => Right(tRecipeDetail));
      //act
      bloc.add(GetDataForRecipeDetail(tKey));
      await untilCalled(mockGetRecipeDetail(any));
      //assert
      verify(mockGetRecipeDetail(Params(key: tKey)));
    });

    test('should emit [loading, loaded] when data is gotten successfully',
        () async {
      //arrange
      when(mockGetRecipeDetail(any))
          .thenAnswer((_) async => Right(tRecipeDetail));
      //assert later
      final expected = [Loading(), Loaded(recipe: tRecipeDetail)];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeDetail(tKey));
    });

    test('should emit [loading, loaded] when getting data fails', () async {
      //arrange
      when(mockGetRecipeDetail(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeDetail(tKey));
    });

    test(
        'should emit [loading, loaded] with proper msg for the error when getting data fails',
        () async {
      //arrange
      when(mockGetRecipeDetail(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: CACHE_FAILURE_MESSAGE),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetDataForRecipeDetail(tKey));
    });
  });
}
