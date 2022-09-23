import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/My_Them.dart';
import 'package:to_do/database/my_data_base.dart';
import 'package:to_do/database/task.dart';
import 'package:to_do/dialogeUtils.dart';
import 'package:to_do/home/taskes_list/edit_screen.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  TaskWidget(this.task);
  @override
  Widget build(BuildContext context) {
    return
        // Slidable :  اللى فاجنب delete بتاعت
        InkWell(
      onTap: () {
        //  هعمل Navigator بكدا عشان امرر task كاكنوستراكتور عشان استخدمو هناك
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Edit_Screen(task)));
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Slidable(
          /// عايز اجبها من على الليمين ؟؟
          // The startactionpane is the one at the left or the top side.
          startActionPane: ActionPane(
            motion: DrawerMotion(), // دا الاستايل بتاع الاسكرول
            children: [
              SlidableAction(
                onPressed: (_) {
                  MyDatabase.deleteTask(task)
                      // هتسدعى اما الفانكشن future  تخلص وتجيب الداتا : then
                      .then((value) {
                    showmessage(context, 'Task deleted Successfully',
                        posActionName: 'ok');
                  })
                      // هيتنادى عليها اما يحصل ايرور ومتجرعش كلام
                      .onError((error, stackTrace) {
                    showmessage(context, 'something Wrong happen',
                        posActionName: 'ok');
                  })
                      // الوقت اللى المفروض بحد اقصى باخد الداتا عشان تحمل لو قعدت اكتر من كده هتتخرن لوكال

                      .timeout(const Duration(seconds: 5), onTimeout: () {
                    showmessage(
                        context,
                        'Data saved in locally and '
                        'when Internet on well deleted',
                        posActionName: 'ok');
                  });
                },
                icon: Icons.delete,
                backgroundColor: MyThem.red,
                label: 'Delete',
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
              ),
              // SlidableAction(
              //   onPressed: (_) {},
              //   backgroundColor: Color(0xFF21B7CA),
              //   foregroundColor: Colors.white,
              //   icon: Icons.share,
              //   label: 'Share',
              // ),
              // ممكن اعمل اكتر من واحده بص على اللينك دا :
              //https://pub.dev/packages/flutter_slidable
            ],
          ),

          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.white),
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: task.isDone!
                        ? MyThem.geren
                        : Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.tittle ?? '',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: task.isDone!
                                        ? MyThem.geren
                                        : Theme.of(context).primaryColor,
                                  )),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            task.descrabtion ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                // Spacer(),
                InkWell(
                  onTap: () {
                    MyDatabase.editIsDone(task);
                  },
                  child: task.isDone!
                      ? Text(
                          ' عاش فشخ Done !!!',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyThem.geren),
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
