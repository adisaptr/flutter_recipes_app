import 'package:equatable/equatable.dart';

class RecipeArticle extends Equatable {
  final String title;
  final String url;
  final String key;

  const RecipeArticle(
      {required this.title, required this.url, required this.key});

  @override
  List<Object?> get props => [title, url, key];
}
