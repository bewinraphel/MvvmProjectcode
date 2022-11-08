// GENERATED CODE - DO NOT MODIFY BY HAND

part of '_transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class tranactionModelAdapter extends TypeAdapter<tranactionModel> {
  @override
  final int typeId = 3;

  @override
  tranactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return tranactionModel(
      purpose: fields[0] as String,
      amount: fields[1] as double,
      category: fields[4] as Categorymodel,
      Type: fields[3] as Categorytype,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, tranactionModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.purpose)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.Type)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is tranactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
