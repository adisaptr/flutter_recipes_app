import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/data/models/recipe_detail_model.dart';
import 'package:recipes_app/features/domain/entities/recipe_detail.dart';
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart';
import 'package:recipes_app/features/domain/usecases/get_detail.dart';
import 'get_recipe_detail_test.mocks.dart';

@GenerateMocks([RecipeRepository])
void main() {
  late GetRecipeDetail usecase;
  late MockRecipeRepository mockRecipeRepository;
  setUp(() {
    mockRecipeRepository = MockRecipeRepository();
    usecase = GetRecipeDetail(mockRecipeRepository);
  });

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

  test('should get recipe detail from repository', () async {
    //arrange
    when(mockRecipeRepository.getRecipeDetail(any))
        .thenAnswer((_) async => Right(tRecipeDetail));
    //act
    final result = await usecase(Params(key: tKey));
    //assert
    expect(result, Right(tRecipeDetail));
    verify(mockRecipeRepository.getRecipeDetail(tKey));
    verifyNoMoreInteractions(mockRecipeRepository);
  });
}
