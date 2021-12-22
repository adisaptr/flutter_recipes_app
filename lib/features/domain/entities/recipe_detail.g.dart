// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeDetailAdapter extends TypeAdapter<RecipeDetail> {
  @override
  final int typeId = 0;

  @override
  RecipeDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeDetail(
      title: fields[0] as String,
      thumb: fields[1] as String,
      servings: fields[2] as String,
      times: fields[3] as String,
      dificulty: fields[4] as String,
      author: fields[5] as Author,
      desc: fields[6] as String,
      needItem: (fields[7] as List).cast<NeedItem>(),
      ingredient: (fields[8] as List).cast<String>(),
      step: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RecipeDetail obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.thumb)
      ..writeByte(2)
      ..write(obj.servings)
      ..writeByte(3)
      ..write(obj.times)
      ..writeByte(4)
      ..write(obj.dificulty)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.desc)
      ..writeByte(7)
      ..write(obj.needItem)
      ..writeByte(8)
      ..write(obj.ingredient)
      ..writeByte(9)
      ..write(obj.step);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
