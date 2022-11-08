import 'package:flutter/material.dart';
import 'package:money/home/db/category/category_model.dart';
import 'package:money/screens/expense_categorylist.dart';
import 'package:money/screens/income_category_list.dart';

class screencategory extends StatefulWidget {
  const screencategory({Key? key}) : super(key: key);

  @override
  State<screencategory> createState() => _screencategoryState();
}

class _screencategoryState extends State<screencategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    categoryDB().refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            tabs: [
              Tab(
                text: 'INCOME',
              ),
              Tab(
                text: 'EXPENSE',
              ),
            ]),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: [IncomeCategoryList(), ExpenseCategoryList()]),
        )
      ],
    );
  }
}
