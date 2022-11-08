import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money/home/db/category/category_model.dart';
import 'package:money/home/models/category/caregories_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categoryDB().incomeCategoryList,
        builder: (BuildContext ctx, List<Categorymodel> newList, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = newList[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          categoryDB.instance.deleteCategory(category.id);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: newList.length);
        });
  }
}
