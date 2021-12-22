part of 'recipe_article_detail_bloc.dart';

abstract class RecipeArticleDetailState extends Equatable {
  const RecipeArticleDetailState();

  @override
  List<Object> get props => [];
}

class Empty extends RecipeArticleDetailState {}

class Loading extends RecipeArticleDetailState {}

class Loaded extends RecipeArticleDetailState {
  RecipeArticleDetail article;

  Loaded({required this.article});
}

class Error extends RecipeArticleDetailState {
  final String message;

  const Error({required this.message});
}
