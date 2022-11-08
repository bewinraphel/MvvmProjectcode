import 'package:hive/hive.dart';
import 'package:money/home/models/category/caregories_model.dart';
part '_transaction_model.g.dart';

@HiveType(typeId: 3)
class tranactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  Categorytype Type;
  @HiveField(4)
  final Categorymodel category;
  String? id;

  tranactionModel({
    required this.purpose,
    required this.amount,
    required this.category,
    required this.Type,
    required this.date,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
