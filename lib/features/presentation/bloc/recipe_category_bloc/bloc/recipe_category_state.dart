part of 'recipe_category_bloc.dart';

abstract class RecipeCategoryState extends Equatable {
  const RecipeCategoryState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeCategoryState {}

class Loading extends RecipeCategoryState {}

class Loaded extends RecipeCategoryState {
  List<RecipeCategory> category;

  Loaded({required this.category});
}

class Error extends RecipeCategoryState {
  final String message;

  const Error({required this.message});
}
