import 'package:flutter/material.dart';
import 'package:money/home/screen_home.dart';

class moneybottomnavigationbar extends StatelessWidget {
  const moneybottomnavigationbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedindexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
            currentIndex: updatedIndex,
            onTap: (newindex) {
              ScreenHome.selectedindexNotifier.value = newindex;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "transaction'"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'home'),
            ]);
      },
    );
  }
}
