import 'package:flutter/material.dart';
import 'package:to_do/home/addTaskBottomSheet.dart';

import 'package:to_do/home/setting/setting_tap.dart';
import 'package:to_do/home/taskes_list/taskes_list_tap.dart';

class home_screen extends StatefulWidget {
  static const String Routname = 'homeScreen';

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To do  list app ',
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // عشان ادى الايقون اللى ف النص الحدود بضيف دول ل bottom
        shape: CircularNotchedRectangle(),
        notchMargin: 10,

        child: BottomNavigationBar(
            currentIndex:
                selectedIndex, //currentIndex : دا اللى بيتحكم ف الشاشه المعروضه
            // عملت currentIndex بمتغير عشان اعرف اتنقل بين التاب
            onTap: (index) {
              // عشان اما يدوس يروح عالتاب اللى اتداست عليها
              selectedIndex = index;
              setState(() {});
            },
            items: const [
              // ImageIcon : هنا بتحول الصوره وتخليها تتعامل معامله الايقون
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'list',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'setting',
              ),
            ]),
      ),

      // عشان اغير مكان  floatingActionButton واخليه على appbar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // shape : عشان اديلو حدود
        shape: const StadiumBorder(
            side: BorderSide(color: Colors.white, width: 4)),
        onPressed: () {
          showAddtaskBottomsheet();
        },
        child: const Icon(Icons.add),
      ),

      body: Taps[selectedIndex],
    );
  }

  List<Widget> Taps = [TaskesListTap(), Setting_tap()];

  void showAddtaskBottomsheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildcontext) {
        return AddTaskbottmSheet();
      },
      // isScrollControlled: true // دا لو عايزها تاخد الاسكرين كلها
    );
  }
}
