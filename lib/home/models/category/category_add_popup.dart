import 'package:flutter/material.dart';
import 'package:money/home/db/category/category_model.dart';
import 'package:money/home/models/category/caregories_model.dart';

ValueNotifier<Categorytype> selectedCategory =
    ValueNotifier(Categorytype.expense);
Future<void> ShowCategoryAddPopup(BuildContext context) async {
  final _nameeditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('add category'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButton(title: 'income', type: Categorytype.income),
                  RadioButton(title: 'expense', type: Categorytype.expense),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameeditingController,
                decoration: InputDecoration(
                    hintText: 'category text', border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  final _name = _nameeditingController.text;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = selectedCategory.value;
                  final _category = Categorymodel(
                      id: DateTime.now().microsecond.toString(),
                      name: _name,
                      type: _type);
                  categoryDB.instance.insertCategory(_category);
                  Navigator.of(ctx).pop();
                },
                child: const Text('add'))
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final Categorytype type;
  RadioButton({required this.title, required this.type, Key? key})
      : super(key: key);

  Categorytype? _type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategory,
          builder: (BuildContext ctx, Categorytype newcategorytype, Widget? _) {
            return Radio<Categorytype>(
              value: type,
              groupValue: newcategorytype,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategory.value = value;
                selectedCategory.notifyListeners();
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
