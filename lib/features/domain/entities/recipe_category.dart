import 'package:equatable/equatable.dart';

class RecipeCategory extends Equatable {
  final String category;
  final String url;
  final String key;

  const RecipeCategory(
      {required this.category, required this.url, required this.key});

  @override
  List<Object?> get props => [category, url, key];
}
