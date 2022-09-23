// هعمل كلاس عشان استخدم فيه الداتا بيز
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/database/task.dart';
import 'package:to_do/date_utils.dart';

class MyDatabase {
  // هعمل فانكشن عشان اجيب ووادى الداتا من الفايربيز واما ااحتاج اعمل insert or delete استدعى اسمها مره واحده
  static CollectionReference<Task> getTaskesCollection() {
    // هجيب اوبجكت من الفايريز عشان استخدمها هنا

    return FirebaseFirestore.instance.collection('tasks')
        // ازاى بستخدم الداتا واحولها من الفاير ستور ل اوبجكت من نوع task
        .withConverter<Task>(fromFirestore: (snapshot, options) {
      return Task.fromFireStore(snapshot.data() ?? {});
    },
            // وازاى بخزن الداتا جوا الفاير ستور
            toFirestore: (task, options) {
      return task.toFireStore();
    });
  }

  // بعد كدا اى حاجه عايز اعملها على الداتا (task) هروح استدعى الفانكشن اللى فوق دى مره واحده
  //  1- عشان insert OR ADD
  //هعمل فانكشن عشان اضيف الداتا وهمررلها براميتر الكلاس اللى عملته بيتعامل مع الفايربيز

  static Future<void> insertTask(Task task) {
    //taskCollection : a set of document
    var taskCollection = getTaskesCollection();
    var taskDoc = taskCollection.doc(); // create a new document
    task.id = taskDoc.id;
    return taskDoc.set(task);
  }

// هعمل فانكشن عشان اعرض بيه الداتا اللى عملتلها add
  static Future<QuerySnapshot<Task>> getAllTaskes(DateTime selectedDate) async {
    //  read data once
    // وعايز افلتر الدتا اللى عندى عشان اطلع كل يوم بالتاسك اللى فيه
    return await getTaskesCollection()
        // هعمل فلتر بيها عشان تعرض التاسك بتاع كل يوم بس
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).microsecondsSinceEpoch)
        .get();
  }

  // هعمل فانكشن عشان من خلالها اما يحصل اى تغير سواء كان delete او insert يسمع فى screen
  static Stream<QuerySnapshot<Task>> listenForTaskRealTimeUbdate(
      DateTime selectedDate) {
    // بتسمع للتغيرات اللى حصلت
    return getTaskesCollection()
        // هعمل فلتر بيها عشان تعرض التاسك بتاع كل يوم بس
        .where('dateTime',
            isEqualTo: dateOnly(selectedDate).microsecondsSinceEpoch)
        .snapshots();
  }

  // هعمل فانكشن عشان اعمل بيها delete
  static Future<void> deleteTask(Task task) {
    var taskdoc = getTaskesCollection().doc(task.id); // كدا دخلت على table
    return taskdoc.delete();
  }

  // هعمل فانكشن بتاعت is done عشان اما يدوس على الصح يتحول الباقى ل اخضر
  static editIsDone(Task task) {
    CollectionReference todoRef = getTaskesCollection(); // كدا دخلت على table
    todoRef.doc(task.id).update({'isDone': task.isDone! ? false : true});
  }

  // هعمل فانكشن للتعديل اما يعدل فى  edit screen يسمع فى home

  static Future<void>editScreenDetails(Task task) {
    CollectionReference todoRef = getTaskesCollection(); // كدا دخلت على table
    return todoRef.doc(task.id).update({
      'tittle': task.id,
      'descrabtion': task.descrabtion,
      'dateTime': task.dateTime!.microsecondsSinceEpoch
    });
  }
}
