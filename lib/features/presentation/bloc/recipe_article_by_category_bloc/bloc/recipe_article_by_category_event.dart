part of 'recipe_article_by_category_bloc.dart';

abstract class RecipeArticleByCategoryEvent extends Equatable {
  const RecipeArticleByCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeArticleList extends RecipeArticleByCategoryEvent {
  final String key;

  const GetDataForRecipeArticleList(this.key);

  @override
  List<Object> get props => [key];
}
