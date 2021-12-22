part of 'recipe_article_category_bloc.dart';

abstract class RecipeArticleCategoryEvent extends Equatable {
  const RecipeArticleCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeArticleCategory extends RecipeArticleCategoryEvent {}
