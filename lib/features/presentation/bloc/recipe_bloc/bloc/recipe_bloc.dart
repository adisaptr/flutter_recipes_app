import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_app/core/error/failure.dart';
import 'package:recipes_app/core/usecases/usecase.dart';

import '../../../../domain/entities/recipe.dart';
import '../../../../domain/usecases/get_recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final GetRecipe getRecipe;

  RecipeBloc({required this.getRecipe}) : super(Empty()) {
    on<GetDataForRecipe>((event, emit) async {
      emit(Loading());
      final failureOrSuccess = await getRecipe(NoParam());
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
