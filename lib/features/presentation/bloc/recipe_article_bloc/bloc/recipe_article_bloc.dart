import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/recipe_article.dart';
import '../../../../domain/usecases/get_recipe_article.dart';

part 'recipe_article_event.dart';
part 'recipe_article_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RecipeArticleBloc extends Bloc<RecipeArticleEvent, RecipeArticleState> {
  final GetRecipeArticle getRecipeArticle;

  RecipeArticleBloc({required this.getRecipeArticle}) : super(Empty()) {
    on<GetDataForRecipeArticle>((event, emit) async {
      emit(Loading());
      final failureOrSuccess = await getRecipeArticle(NoParam());
      failureOrSuccess.fold((failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      }, (article) {
        emit(Loaded(article: article));
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
