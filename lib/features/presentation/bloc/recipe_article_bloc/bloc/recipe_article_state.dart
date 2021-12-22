part of 'recipe_article_bloc.dart';

abstract class RecipeArticleState extends Equatable {
  const RecipeArticleState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeArticleState {}

class Loading extends RecipeArticleState {}

class Loaded extends RecipeArticleState {
  List<RecipeArticle> article;

  Loaded({required this.article});
}

class Error extends RecipeArticleState {
  final String message;

  const Error({required this.message});
}
