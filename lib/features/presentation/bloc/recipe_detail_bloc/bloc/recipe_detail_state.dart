part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailState extends Equatable {
  const RecipeDetailState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeDetailState {}

class Loading extends RecipeDetailState {}

class Loaded extends RecipeDetailState {
  RecipeDetail recipe;

  Loaded({required this.recipe});
}

class Error extends RecipeDetailState {
  final String message;

  const Error({required this.message});
}
