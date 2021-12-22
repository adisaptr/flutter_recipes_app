part of 'recipe_by_search_bloc.dart';

abstract class RecipeBySearchState extends Equatable {
  const RecipeBySearchState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeBySearchState {}

class Loading extends RecipeBySearchState {}

class Loaded extends RecipeBySearchState {
  List<RecipeBySearch> recipe;

  Loaded({required this.recipe});
}

class Error extends RecipeBySearchState {
  final String message;

  const Error({required this.message});
}
