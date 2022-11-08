import 'package:hive/hive.dart';
part 'caregories_model.g.dart';

@HiveType(typeId: 2)
enum Categorytype {
  @HiveField(0)
  income,
  @HiveField(1)
  expense
}

@HiveType(typeId: 1)
class Categorymodel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isDeleted;
  @HiveField(3)
  final Categorytype type;

  Categorymodel(
      {required this.id,
      required this.name,
      this.isDeleted = false,
      required this.type});
}
