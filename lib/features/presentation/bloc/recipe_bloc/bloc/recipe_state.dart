part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeState {}

class Loading extends RecipeState {}

class Loaded extends RecipeState {
  List<Recipe> recipe;

  Loaded({required this.recipe});
}

class Error extends RecipeState {
  final String message;

  const Error({required this.message});
}
