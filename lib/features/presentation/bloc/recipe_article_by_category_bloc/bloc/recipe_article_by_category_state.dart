part of 'recipe_article_by_category_bloc.dart';

abstract class RecipeArticleByCategoryState extends Equatable {
  const RecipeArticleByCategoryState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeArticleByCategoryState {}

class Loading extends RecipeArticleByCategoryState {}

class Loaded extends RecipeArticleByCategoryState {
  List<RecipeArticleByCategory> article;

  Loaded({required this.article});
}

class Error extends RecipeArticleByCategoryState {
  final String message;

  const Error({required this.message});
}
