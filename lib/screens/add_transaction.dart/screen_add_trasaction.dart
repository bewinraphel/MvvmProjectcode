import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money/home/db/category/category_model.dart';
import 'package:money/home/models/category/caregories_model.dart';
import 'package:money/home/models/transation/_transaction_model.dart';
import 'package:money/home/models/transation/transaction_db.dart';

class screen_add_transaction extends StatefulWidget {
  screen_add_transaction({Key? key}) : super(key: key);
  static const routeName = "add_transaction";

  @override
  State<screen_add_transaction> createState() => _screen_add_transactionState();
}

class _screen_add_transactionState extends State<screen_add_transaction> {
  DateTime? _selectedDate;

  Categorytype? _selectedCategoryType;
  Categorymodel? _selectedCategoryModel;

  final _purpose_TextEditingController = TextEditingController();
  final _amount_TextEditingController = TextEditingController();
  String? _categoryId;
  @override
  void initState() {
    _selectedCategoryType = Categorytype.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///purpose
            TextField(
              controller: _purpose_TextEditingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "purpose",
              ),
            ),
            //amount
            TextField(
              controller: _amount_TextEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Amount"),
            ),

            ///calender
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now(),
                );
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  print(_selectedDate.toString());
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label: Text(_selectedDate == null
                  ? 'select date'
                  : _selectedDate!.toString()),
            ),

            ///income
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                        value: Categorytype.income,
                        groupValue: _selectedCategoryType,
                        onChanged: (newvalue) {
                          setState(() {
                            _selectedCategoryType = Categorytype.income;
                            _categoryId = null;
                          });
                        }),
                    Text("income"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: Categorytype.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newvalue) {
                          setState(() {
                            _selectedCategoryType = Categorytype.expense;
                            _categoryId = null;
                          });
                        }),
                    Text("expense"),

                    ///droptown
                  ],
                ),
              ],
            ),

            ///droptown
            Card(
              shape: StadiumBorder(
                side: BorderSide(
                  color: Colors.black,
                ),
              ),
              elevation: 10,
              child: DropdownButton<String>(
                  hint: Text("slected category"),
                  value: _categoryId,
                  items: (_selectedCategoryType == Categorytype.income
                          ? categoryDB.instance.incomeCategoryList
                          : categoryDB.instance.expenseCategoryList)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          child: Text(e.name)),
                      value: e.id,
                      onTap: () {
                        _selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      _categoryId = newvalue!;
                    });
                  }),
            ),
            // submitt
            ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: Text("submit"))
          ],
        ),
      )),
    );
  }

  Future addTransaction() async {
    final _purposeText = _purpose_TextEditingController.text;
    final _amountText = _amount_TextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryId == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    final _parseAmount = double.tryParse(_amountText);
    if (_parseAmount == null) {
      return;
    }
    final _model = tranactionModel(
        purpose: _amountText,
        amount: _parseAmount,
        category: _selectedCategoryModel!,
        Type: _selectedCategoryType!,
        date: _selectedDate!);

    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
