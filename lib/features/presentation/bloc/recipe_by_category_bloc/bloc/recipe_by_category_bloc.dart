import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/recipe.dart';
import '../../../../domain/usecases/get_recipe_by_category.dart';

part 'recipe_by_category_event.dart';
part 'recipe_by_category_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RecipeByCategoryBloc
    extends Bloc<RecipeByCategoryEvent, RecipeByCategoryState> {
  final GetRecipeByCategory getRecipeByCategory;
  RecipeByCategoryBloc({required this.getRecipeByCategory}) : super(Empty()) {
    on<GetDataForRecipeList>((event, emit) async {
      emit(Loading());
      final failureOrSuccess =
          await getRecipeByCategory(Params(key: event.key));
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
