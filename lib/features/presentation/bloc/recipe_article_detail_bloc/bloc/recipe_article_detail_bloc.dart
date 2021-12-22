import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/recipe_article_detail.dart';
import '../../../../domain/usecases/get_recipe_article_detail.dart';

part 'recipe_article_detail_event.dart';
part 'recipe_article_detail_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RecipeArticleDetailBloc
    extends Bloc<RecipeArticleDetailEvent, RecipeArticleDetailState> {
  final GetRecipeArticleDetail getRecipeArticleDetail;
  RecipeArticleDetailBloc({required this.getRecipeArticleDetail})
      : super(Empty()) {
    on<GetDataForRecipeArticleDetail>((event, emit) async {
      emit(Loading());
      final failureOrSuccess =
          await getRecipeArticleDetail(Params(key: event.key));
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
