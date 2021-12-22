import 'package:equatable/equatable.dart';

class RecipeBySearch extends Equatable {
  final String title;
  final String thumb;
  final String key;
  final String times;
  final String serving;
  final String difficulty;

  const RecipeBySearch(
      {required this.title,
      required this.thumb,
      required this.key,
      required this.times,
      required this.serving,
      required this.difficulty});
  @override
  List<Object?> get props => [title, thumb, key, times, serving, difficulty];
}
