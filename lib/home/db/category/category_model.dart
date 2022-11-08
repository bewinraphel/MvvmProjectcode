import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money/home/models/category/caregories_model.dart';

const CATEGORY_DB_NAME = 'category_database';

abstract class CategoryDBfunction {
  Future<List<Categorymodel>> getCategories();
  Future<void> insertCategory(Categorymodel values);
  Future<void> deleteCategory(String category);
}

class categoryDB implements CategoryDBfunction {
  categoryDB._internal();
  static categoryDB instance = categoryDB._internal();
  factory categoryDB() {
    return instance;
  }
  ValueNotifier<List<Categorymodel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<Categorymodel>> expenseCategoryList = ValueNotifier([]);
  @override
  Future<void> insertCategory(Categorymodel values) async {
    final _categoryDB = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);

    await _categoryDB.put(values.id, values);
    refreshUi();
  }

  @override
  Future<List<Categorymodel>> getCategories() async {
    final _categoryDB = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUi() async {
    final _allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    Future.forEach(_allCategories, (Categorymodel category) {
      if (category.type == Categorytype.income) {
        incomeCategoryList.value.add(category);
      } else {
        expenseCategoryList.value.add(category);
      }
    });
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<Categorymodel>(CATEGORY_DB_NAME);
    _categoryDB.delete(categoryID);
    refreshUi();
  }
}
