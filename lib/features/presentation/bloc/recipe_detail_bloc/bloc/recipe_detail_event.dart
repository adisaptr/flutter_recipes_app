part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeDetail extends RecipeDetailEvent {
  final String key;

  const GetDataForRecipeDetail(this.key);

  @override
  List<Object> get props => [key];
}
