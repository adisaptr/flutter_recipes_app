import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_app/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}

class Params extends Equatable {
  final String key;

  const Params({required this.key});

  @override
  List<Object> get props => [key];
}
