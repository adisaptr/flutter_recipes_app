import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_article_by_category.dart';
import 'package:recipes_app/features/domain/usecases/get_recipe_article_by_category.dart';

part 'recipe_article_by_category_event.dart';
part 'recipe_article_by_category_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RecipeArticleByCategoryBloc
    extends Bloc<RecipeArticleByCategoryEvent, RecipeArticleByCategoryState> {
  final GetRecipeArticleByCategory getRecipeArticleByCategory;
  RecipeArticleByCategoryBloc({required this.getRecipeArticleByCategory})
      : super(Empty()) {
    on<GetDataForRecipeArticleList>((event, emit) async {
      emit(Loading());
      final failureOrSuccess =
          await getRecipeArticleByCategory(Params(key: event.key));
      failureOrSuccess.fold((failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      }, (recipe) {
        emit(Loaded(article: recipe));
      });
    });
  }
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
