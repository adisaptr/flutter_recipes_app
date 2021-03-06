// Mocks generated by Mockito 5.0.16 from annotations
// in recipes_app/test/features/presentation/bloc/recipe_by_search_bloc/recipe_by_search_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:recipes_app/core/error/failure.dart' as _i6;
import 'package:recipes_app/core/usecases/usecase.dart' as _i8;
import 'package:recipes_app/features/domain/entities/recipe_by_search.dart'
    as _i7;
import 'package:recipes_app/features/domain/repositories/recipe_repository.dart'
    as _i2;
import 'package:recipes_app/features/domain/usecases/get_recipe_by_search.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeRecipeRepository_0 extends _i1.Fake implements _i2.RecipeRepository {
}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetRecipeBySearch].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRecipeBySearch extends _i1.Mock implements _i4.GetRecipeBySearch {
  MockGetRecipeBySearch() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RecipeRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeRecipeRepository_0()) as _i2.RecipeRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.RecipeBySearch>>> call(
          _i8.Params? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
              returnValue: Future<
                      _i3.Either<_i6.Failure, List<_i7.RecipeBySearch>>>.value(
                  _FakeEither_1<_i6.Failure, List<_i7.RecipeBySearch>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.RecipeBySearch>>>);
  @override
  String toString() => super.toString();
}
