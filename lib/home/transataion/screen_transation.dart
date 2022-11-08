import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/home/db/category/category_model.dart';
import 'package:money/home/models/category/caregories_model.dart';
import 'package:money/home/models/transation/_transaction_model.dart';
import 'package:money/home/models/transation/transaction_db.dart';

class screentransaction extends StatelessWidget {
  const screentransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    categoryDB.instance.refreshUi();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionlistNotifier,
        builder: (BuildContext ctx, List<tranactionModel> newlist, Widget? _) {
          return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemBuilder: (ctx, index) {
                final value = newlist[index];
                return Card(
                  elevation: 0,
                  child: ListTile(
                    trailing: IconButton(
                        onPressed: () {
                          TransactionDB.instance.delete(value.id!);
                        },
                        icon: Icon(Icons.delete)),
                    leading: CircleAvatar(
                        backgroundColor: value.Type == Categorytype.income
                            ? Colors.green
                            : Colors.red,
                        radius: 50,
                        child: Text(
                          parseDate(value.date),
                          textAlign: TextAlign.center,
                        )),
                    title: Text('RS ${value.amount}'),
                    subtitle: Text(value.category.name),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 19,
                );
              },
              itemCount: newlist.length);
        });
  }
}

String parseDate(DateTime date) {
  final _date = DateFormat.MMMd().format(date);
  final _splitedDate = _date.split('');
  return '${_splitedDate.last}\n${_splitedDate.first}';
}
