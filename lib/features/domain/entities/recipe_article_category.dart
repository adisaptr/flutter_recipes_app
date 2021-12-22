import 'package:equatable/equatable.dart';

class RecipeArticleCategory extends Equatable {
  final String title;
  final String key;

  const RecipeArticleCategory({required this.title, required this.key});

  @override
  List<Object?> get props => [title, key];
}
