part of 'recipe_by_category_bloc.dart';

abstract class RecipeByCategoryEvent extends Equatable {
  const RecipeByCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeList extends RecipeByCategoryEvent {
  final String key;

  const GetDataForRecipeList(this.key);

  @override
  List<Object> get props => [key];
}
