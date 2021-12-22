part of 'recipe_article_bloc.dart';

abstract class RecipeArticleEvent extends Equatable {
  const RecipeArticleEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeArticle extends RecipeArticleEvent {}
