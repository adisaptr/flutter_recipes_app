part of 'recipe_article_detail_bloc.dart';

abstract class RecipeArticleDetailEvent extends Equatable {
  const RecipeArticleDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeArticleDetail extends RecipeArticleDetailEvent {
  final String key;

  const GetDataForRecipeArticleDetail(this.key);

  @override
  List<Object> get props => [key];
}
