// Mocks generated by Mockito 5.0.16 from annotations
// in recipes_app/test/features/data/repositories/recipe_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:recipes_app/features/data/datasources/recipe_remote_data_source.dart'
    as _i4;
import 'package:recipes_app/features/data/models/recipe_article_by_category_model.dart'
    as _i11;
import 'package:recipes_app/features/data/models/recipe_article_category_model.dart'
    as _i10;
import 'package:recipes_app/features/data/models/recipe_article_detail_model.dart'
    as _i3;
import 'package:recipes_app/features/data/models/recipe_article_model.dart'
    as _i9;
import 'package:recipes_app/features/data/models/recipe_by_search_model.dart'
    as _i8;
import 'package:recipes_app/features/data/models/recipe_category_model.dart'
    as _i7;
import 'package:recipes_app/features/data/models/recipe_detail_model.dart'
    as _i2;
import 'package:recipes_app/features/data/models/recipe_model.dart' as _i6;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeRecipeDetailModel_0 extends _i1.Fake
    implements _i2.RecipeDetailModel {}

class _FakeRecipeArticleDetailModel_1 extends _i1.Fake
    implements _i3.RecipeArticleDetailModel {}

/// A class which mocks [RecipeRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRecipeRemoteDataSource extends _i1.Mock
    implements _i4.RecipeRemoteDataSource {
  MockRecipeRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<List<_i6.RecipeModel>> getRecipe() => (super.noSuchMethod(
          Invocation.method(#getRecipe, []),
          returnValue: Future<List<_i6.RecipeModel>>.value(<_i6.RecipeModel>[]))
      as _i5.Future<List<_i6.RecipeModel>>);
  @override
  _i5.Future<List<_i7.RecipeCategoryModel>> getRecipeCategory() =>
      (super.noSuchMethod(Invocation.method(#getRecipeCategory, []),
              returnValue: Future<List<_i7.RecipeCategoryModel>>.value(
                  <_i7.RecipeCategoryModel>[]))
          as _i5.Future<List<_i7.RecipeCategoryModel>>);
  @override
  _i5.Future<List<_i6.RecipeModel>> getRecipeByCategory(String? key) =>
      (super.noSuchMethod(Invocation.method(#getRecipeByCategory, [key]),
              returnValue:
                  Future<List<_i6.RecipeModel>>.value(<_i6.RecipeModel>[]))
          as _i5.Future<List<_i6.RecipeModel>>);
  @override
  _i5.Future<List<_i8.RecipeBySearchModel>> getRecipeBySearch(String? key) =>
      (super.noSuchMethod(Invocation.method(#getRecipeBySearch, [key]),
              returnValue: Future<List<_i8.RecipeBySearchModel>>.value(
                  <_i8.RecipeBySearchModel>[]))
          as _i5.Future<List<_i8.RecipeBySearchModel>>);
  @override
  _i5.Future<List<_i9.RecipeArticleModel>> getRecipeArticle() =>
      (super.noSuchMethod(Invocation.method(#getRecipeArticle, []),
              returnValue: Future<List<_i9.RecipeArticleModel>>.value(
                  <_i9.RecipeArticleModel>[]))
          as _i5.Future<List<_i9.RecipeArticleModel>>);
  @override
  _i5.Future<_i2.RecipeDetailModel> getRecipeDetail(String? key) =>
      (super.noSuchMethod(Invocation.method(#getRecipeDetail, [key]),
              returnValue: Future<_i2.RecipeDetailModel>.value(
                  _FakeRecipeDetailModel_0()))
          as _i5.Future<_i2.RecipeDetailModel>);
  @override
  _i5.Future<List<_i10.RecipeArticleCategoryModel>>
      getRecipeArticleCategory() => (super.noSuchMethod(
              Invocation.method(#getRecipeArticleCategory, []),
              returnValue: Future<List<_i10.RecipeArticleCategoryModel>>.value(
                  <_i10.RecipeArticleCategoryModel>[]))
          as _i5.Future<List<_i10.RecipeArticleCategoryModel>>);
  @override
  _i5.Future<List<_i11.RecipeArticleByCategoryModel>>
      getRecipeArticleByCategory(String? key) => (super.noSuchMethod(
          Invocation.method(#getRecipeArticleByCategory, [key]),
          returnValue: Future<List<_i11.RecipeArticleByCategoryModel>>.value(
              <_i11.RecipeArticleByCategoryModel>[])) as _i5
          .Future<List<_i11.RecipeArticleByCategoryModel>>);
  @override
  _i5.Future<_i3.RecipeArticleDetailModel> getRecipeArticleDetail(
          String? key) =>
      (super.noSuchMethod(Invocation.method(#getRecipeArticleDetail, [key]),
              returnValue: Future<_i3.RecipeArticleDetailModel>.value(
                  _FakeRecipeArticleDetailModel_1()))
          as _i5.Future<_i3.RecipeArticleDetailModel>);
  @override
  String toString() => super.toString();
}
