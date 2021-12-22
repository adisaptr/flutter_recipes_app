import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final String title;
  final String thumb;
  final String key;
  final String times;
  final String portion;
  final String dificulty;

  const Recipe(
      {required this.title,
      required this.thumb,
      required this.key,
      required this.times,
      required this.portion,
      required this.dificulty});
  @override
  List<Object?> get props => [title, thumb, key, times, portion, dificulty];
}
