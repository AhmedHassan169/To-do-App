import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/database/my_data_base.dart';
import 'package:to_do/database/task.dart';
import 'package:to_do/home/taskes_list/task_widget.dart';
import 'package:to_do/provider/setting_provider.dart';

class TaskesListTap extends StatefulWidget {
  @override
  State<TaskesListTap> createState() => _TaskesListTapState();
}

class _TaskesListTapState extends State<TaskesListTap> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<Setting_provider>(context);
    return Container(
      child: Column(
        children: [
          // هجيب calender دى من الموقع دا  : https://pub.dev/packages/calendar_timeline
          CalendarTimeline(
            showYears: true,
            initialDate: selectedDate, // دى بتجيب اليوم المتحدد اول ما افتح
            firstDate: DateTime.now()
                .subtract(Duration(days: 365)), //  طول التقويم من طرحت سنه
            lastDate: DateTime.now().add(Duration(days: 365)), // الى كام
            onDateSelected: (date) {
              // دى الفانكشن اللى اما اليوزر يدوس على يوم معين
              if (date == null) return;
              setState(() {});
              selectedDate = date;
            },
            leftMargin: 20, // ما بين كل الايام وبعضها
            // بعد كدا الالوان
            monthColor: settingsProvider.isDarkMode()? Colors.white: Colors.black,
            dayColor: settingsProvider.isDarkMode()? Colors.white: Colors.black,
            activeDayColor: Theme.of(context).primaryColor,
            activeBackgroundDayColor: settingsProvider.isDarkMode()? Color(0xFF141922):Colors.white,
            dotsColor: Theme.of(context).primaryColor, // النقتطين اللى فوق
            // selectableDayPredicate: (date) => date.day != 23, // بستخدمها اما اكون عايز يوم معين مينفعش يتحدد
            locale: 'en_ISO', // اللغه
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
              stream: MyDatabase.listenForTaskRealTimeUbdate(selectedDate),
              builder: (buildContext, snapshot) {
                // هتشيك اول حاجه لو فيه ايرور
                if (snapshot.hasError) {
                  return Column(children: const [
                    Text('has Error Found, '
                        'please try again'),
                  ]);
                }
                // هتشيك لو الداتا لسه بتحمل او قعدت  فتره كبيره ف التحميل
                else if (snapshot.connectionState == ConnectionState.waiting) {
                  // is loading
                  return const Center(child: CircularProgressIndicator());
                }
                // غير الحالتين اللى فوق لو متنفزوش يعني هيرجع داتا

                var data = snapshot.data?.docs
                    .map((element) => element.data())
                    .toList();
                return ListView.builder(
                  itemBuilder: (buildcontext, index) {
                    return TaskWidget(data![index]);
                  },
                  itemCount: data?.length ?? 0,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
