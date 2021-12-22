import 'package:equatable/equatable.dart';

class RecipeArticleDetail extends Equatable {
  final String title;
  final String thumb;
  final String author;
  final String datePublished;
  final String description;

  const RecipeArticleDetail(
      {required this.title,
      required this.thumb,
      required this.author,
      required this.datePublished,
      required this.description});
  @override
  List<Object?> get props => [title, thumb, author, datePublished, description];
}
