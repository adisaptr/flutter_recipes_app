part of 'recipe_category_bloc.dart';

abstract class RecipeCategoryEvent extends Equatable {
  const RecipeCategoryEvent();

  @override
  List<Object> get props => [];
}

class GetDataForRecipeCategory extends RecipeCategoryEvent {}
