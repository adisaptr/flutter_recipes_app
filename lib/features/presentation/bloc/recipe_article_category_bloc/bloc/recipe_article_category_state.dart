part of 'recipe_article_category_bloc.dart';

abstract class RecipeArticleCategoryState extends Equatable {
  const RecipeArticleCategoryState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeArticleCategoryState {}

class Loading extends RecipeArticleCategoryState {}

class Loaded extends RecipeArticleCategoryState {
  List<RecipeArticleCategory> category;

  Loaded({required this.category});
}

class Error extends RecipeArticleCategoryState {
  final String message;

  const Error({required this.message});
}
