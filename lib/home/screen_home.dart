import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money/home/models/category/category_add_popup.dart';

import 'package:money/home/transataion/screen_transation.dart';
import 'package:money/home/widget/botttom_navigation.dart';
import 'package:money/screens/add_transaction.dart/screen_add_trasaction.dart';
import 'package:money/screens/screen_category.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedindexNotifier = ValueNotifier(0);
  final _pages = [screentransaction(), screencategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: moneybottomnavigationbar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindexNotifier,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (selectedindexNotifier.value == 0) {
            Navigator.of(context).pushNamed(screen_add_transaction.routeName);
          } else {
            print('add category');
            ShowCategoryAddPopup(context);
          }
        },
      ),
    );
  }
}
