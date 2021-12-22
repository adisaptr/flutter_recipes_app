import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/recipe_category.dart';
import '../../../../domain/usecases/get_recipe_category.dart';

part 'recipe_category_event.dart';
part 'recipe_category_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class RecipeCategoryBloc
    extends Bloc<RecipeCategoryEvent, RecipeCategoryState> {
  final GetRecipeCategory getRecipeCategory;
  RecipeCategoryBloc({required this.getRecipeCategory}) : super(Empty()) {
    on<GetDataForRecipeCategory>((event, emit) async {
      emit(Loading());
      final failureOrSuccess = await getRecipeCategory(NoParam());
      failureOrSuccess.fold((failure) {
        emit(Error(message: _mapFailureToMessage(failure)));
      }, (category) {
        emit(Loaded(category: category));
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
