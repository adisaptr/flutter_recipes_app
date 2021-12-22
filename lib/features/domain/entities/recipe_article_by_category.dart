import 'package:equatable/equatable.dart';

class RecipeArticleByCategory extends Equatable {
  final String title;
  final String thumb;
  final String tags;
  final String key;

  const RecipeArticleByCategory(
      {required this.title,
      required this.thumb,
      required this.tags,
      required this.key});
  @override
  List<Object?> get props => [title, thumb, tags, key];
}
