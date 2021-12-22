import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'features/data/datasources/recipe_remote_data_source.dart';
import 'features/data/repositories/recipe_repository_impl.dart';
import 'features/domain/repositories/recipe_repository.dart';
import 'features/domain/usecases/get_detail.dart';
import 'features/domain/usecases/get_recipe.dart';
import 'features/domain/usecases/get_recipe_article.dart';
import 'features/domain/usecases/get_recipe_article_by_category.dart';
import 'features/domain/usecases/get_recipe_article_category.dart';
import 'features/domain/usecases/get_recipe_article_detail.dart';
import 'features/domain/usecases/get_recipe_by_category.dart';
import 'features/domain/usecases/get_recipe_by_search.dart';
import 'features/domain/usecases/get_recipe_category.dart';
import 'features/presentation/bloc/recipe_article_bloc/bloc/recipe_article_bloc.dart';
import 'features/presentation/bloc/recipe_article_by_category_bloc/bloc/recipe_article_by_category_bloc.dart';
import 'features/presentation/bloc/recipe_article_category_bloc/bloc/recipe_article_category_bloc.dart';
import 'features/presentation/bloc/recipe_article_detail_bloc/bloc/recipe_article_detail_bloc.dart';
import 'features/presentation/bloc/recipe_bloc/bloc/recipe_bloc.dart';
import 'features/presentation/bloc/recipe_by_category_bloc/bloc/recipe_by_category_bloc.dart';
import 'features/presentation/bloc/recipe_by_search_bloc/bloc/recipe_by_search_bloc.dart';
import 'features/presentation/bloc/recipe_category_bloc/bloc/recipe_category_bloc.dart';
import 'features/presentation/bloc/recipe_detail_bloc/bloc/recipe_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  //Bloc
  sl.registerFactory(() => RecipeBloc(getRecipe: sl()));
  sl.registerFactory(() => RecipeDetailBloc(getRecipeDetail: sl()));
  sl.registerFactory(() => RecipeArticleBloc(getRecipeArticle: sl()));
  sl.registerFactory(() => RecipeCategoryBloc(getRecipeCategory: sl()));
  sl.registerFactory(() => RecipeByCategoryBloc(getRecipeByCategory: sl()));
  sl.registerFactory(() => RecipeBySearchBloc(getRecipeBySearch: sl()));
  sl.registerFactory(
      () => RecipeArticleByCategoryBloc(getRecipeArticleByCategory: sl()));
  sl.registerFactory(
      () => RecipeArticleCategoryBloc(getRecipeArticleCategory: sl()));
  sl.registerFactory(
      () => RecipeArticleDetailBloc(getRecipeArticleDetail: sl()));

  // Usecase
  sl.registerLazySingleton(() => GetRecipe(sl()));
  sl.registerLazySingleton(() => GetRecipeDetail(sl()));
  sl.registerLazySingleton(() => GetRecipeArticle(sl()));
  sl.registerLazySingleton(() => GetRecipeCategory(sl()));
  sl.registerLazySingleton(() => GetRecipeByCategory(sl()));
  sl.registerLazySingleton(() => GetRecipeBySearch(sl()));
  sl.registerLazySingleton(() => GetRecipeArticleByCategory(sl()));
  sl.registerLazySingleton(() => GetRecipeArticleCategory(sl()));
  sl.registerLazySingleton(() => GetRecipeArticleDetail(sl()));

  //Repository
  sl.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImpl(recipeRemoteDataSource: sl()));

  // Data Source
  sl.registerLazySingleton<RecipeRemoteDataSource>(
      () => RecipeRemoteDataSourceImpl(client: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
