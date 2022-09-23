import 'package:flutter/material.dart';
import 'package:to_do/database/my_data_base.dart';
import 'package:to_do/database/task.dart';
import 'package:to_do/date_utils.dart';
import 'package:to_do/dialogeUtils.dart';

class AddTaskbottmSheet extends StatefulWidget {
  @override
  State<AddTaskbottmSheet> createState() => _AddTaskbottmSheetState();
}

class _AddTaskbottmSheetState extends State<AddTaskbottmSheet> {
  var FormKey = GlobalKey<FormState>(); // غشان ابعتها ل key بتاع form
  // هعمل متغيرين عشان اجيب بيهم الكلام من كل feild واعملو add
  var titleControlar = TextEditingController();
  var desControlar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7 // كدا هخلى طولها يبقي 7. من طول الاسكرين
      ,
      padding: const EdgeInsets.all(12),
      child: Form(
        key: FormKey, // عشان اما ادوس على submit يتاكد ان فيه كلام فى formfild
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add New Task',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            TextFormField(
              // همررلو المتغير عشان اخد الكلام اللى هتكتب بيه
              // بجيب منه الدتا اللى اتكتبت فى الفورم
              controller: titleControlar,
              //validator : field دى الحاجه اللى هاخد بيها الكلام اللى اليوزر كتبه من
              validator: (text) {
                // هترجع String
                // هتشيك لو الكلام فاضى او بعت مسافه يبقي رجع ايرور
                if (text == null || text.trim().isEmpty) {
                  return 'please enter title 3dl';
                } else
                  return null;
              },
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              // همررلو المتغير عشان اخد الكلام اللى هتكتب بيه controller:
              // بجيب منه الدتا اللى اتكتبت فى الفورم
              controller: desControlar,
              validator: (text) {
                // هترجع String
                // هتشيك لو الكلام فاضى او بعت مسافه يبقي رجع ايرور
                if (text == null || text.trim().isEmpty) {
                  return 'please enter descrabtion 3dl';
                } else {
                  return null;
                }
              },
              style: Theme.of(context).textTheme.titleSmall,
              maxLines: 4,
              minLines: 4, // عشان اخلى عدد السطور اللى تتكتب اكتر
              decoration: const InputDecoration(labelText: 'Descrabtion'),
            ),
            const SizedBox(height: 12),
            Text(
              'Select date',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            InkWell(
              onTap: () {
                showDateDialoge();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  '${selectedate.year}/${selectedate.month}/${selectedate.day}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: const Text(
                  'submit',
                ))
          ],
        ),
      ),
    );
  }

  // هعمل متغير عشان اخد بيه اليوم اللى اليوزر بيحددو
  DateTime selectedate = DateTime.now();
  // عشان اما ادوس على التاريخ يطلع النتيجه

  void showDateDialoge() async {
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: selectedate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now()
            .add(const Duration(days: 365))); // يقدر يعمل تاسك لحد سنه قدام
    if (dateTime != null) {
      setState(() {
        selectedate = dateTime;
      });
    }
  }

  void addTask() {
    // لو كان كتب حاجه فى formfild يروح يجبها ولازم يبقي مكتوب حاجه
    if (FormKey.currentState?.validate() == true) {
      // هجيب title
      String title = titleControlar.text;
      // هجيب description
      String des = desControlar.text;
      // هعمل اوبجكت من نوع تاسك عشان اضيف بيه الدتا من الفاير بيز
      Task task = Task(
        // هبدأ اعرفلها المتغيرات بتاعتها واساويها ل اللى مررتها فى text field
        tittle: title,
        descrabtion: des,
        dateTime: dateOnly(selectedate),
        isDone: false,
      );
      // قبل اى حاجه هعرض ShowLoding  عشان تحمل عقبال ما يجيب الداتا
      // وعملت isCancle ب false عشان اجبرو ميطلعش براها الا اما تخلص تحميل
      ShowLoding(context, 'loadingggg......', isCancle: false);

      // دى كده هيتعملها call اما الداتا تتكتب وادوس submit
      MyDatabase.insertTask(task).then((value) {
        hideLoading(context);
        // هتسدعى اما الفانكشن future  تخلص وتجيب الداتا : then
        // واعرض الرساله بالداتا اللى اتضافت فاعمل فانكشن عشان اعرض بيها الرسايل
        // وعرضت posActionName
        showmessage(context, 'el Task added :D', posActionName: 'ok',
            postAction: () {
          Navigator.pop(context); //اقفل
        });
      }).onError((error, stackTrace) {
        hideLoading(context);
        // هيتنادى عليها اما يحصل ايرور ومتجرعش كلام
        showmessage(context, 'fe error');
      })
          // الوقت اللى المفروض بحد اقصى باخد الداتا عشان تحمل لو قعدت اكتر من كده هتتخرن لوكال
          .timeout(Duration(seconds: 5), onTimeout: () {
        hideLoading(context);
        showmessage(context, 'task saved locally');
        // لو احتاجت اقوله اعمل حاجه
      });
    }
  }
}
