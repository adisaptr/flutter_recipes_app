import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';
import 'package:recipes_app/features/domain/entities/recipe_detail.dart';
import 'package:recipes_app/features/domain/usecases/get_detail.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeDetail getRecipeDetail;
  RecipeDetailBloc({required this.getRecipeDetail}) : super(Empty()) {
    on<GetDataForRecipeDetail>((event, emit) async {
      emit(Loading());
      final failureOrSuccess = await getRecipeDetail(Params(key: event.key));
      failureOrSuccess.fold((failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      }, (recipe) {
        emit(Loaded(recipe: recipe));
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
