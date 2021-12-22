part of 'recipe_by_search_bloc.dart';

abstract class RecipeBySearchEvent extends Equatable {
  const RecipeBySearchEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeSearch extends RecipeBySearchEvent {
  final String key;

  const GetDataForRecipeSearch(this.key);

  @override
  List<Object> get props => [key];
}
