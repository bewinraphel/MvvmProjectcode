import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money/home/models/transation/_transaction_model.dart';

const TRANSACTION_DB_NAME = "transaction-db";

abstract class TranactionDbFunction {
  Future<void> addTransaction(tranactionModel obj);
  Future<List<tranactionModel>> getAllTransaction();
  Future<void> delete(String ID);
}

class TransactionDB implements TranactionDbFunction {
  TransactionDB._insternal();
  static TransactionDB instance = TransactionDB._insternal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<tranactionModel>> transactionlistNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransaction(tranactionModel obj) async {
    final _db = await Hive.openBox<tranactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransaction();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionlistNotifier.value.clear();
    transactionlistNotifier.value.addAll(_list);
    transactionlistNotifier.notifyListeners();
  }

  @override
  Future<List<tranactionModel>> getAllTransaction() async {
    final _db = await Hive.openBox<tranactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> delete(String ID) async {
    final _listDB = await Hive.openBox<tranactionModel>(TRANSACTION_DB_NAME);
    _listDB.delete(ID);
    refresh();
  }
}
