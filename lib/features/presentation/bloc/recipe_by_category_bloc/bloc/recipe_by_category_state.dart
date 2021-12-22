part of 'recipe_by_category_bloc.dart';

abstract class RecipeByCategoryState extends Equatable {
  const RecipeByCategoryState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeByCategoryState {}

class Loading extends RecipeByCategoryState {}

class Loaded extends RecipeByCategoryState {
  List<Recipe> recipe;

  Loaded({required this.recipe});
}

class Error extends RecipeByCategoryState {
  final String message;

  const Error({required this.message});
}
