import 'package:flutter/material.dart';
import 'package:to_do/My_Them.dart';
import 'package:to_do/database/my_data_base.dart';
import 'package:to_do/database/task.dart';

class Edit_Screen extends StatefulWidget {
  static const String Routname = 'edit_screen';
  // هستدعى task هنا عشان امررلو title w des
  Task task;
  Edit_Screen(this.task);

  @override
  State<Edit_Screen> createState() => _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
  var FormKey = GlobalKey<FormState>(); // غشان ابعتها ل key بتاع form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // الازرق اللى ورا
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            color: MyThem.lightPrimary,
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context); // عشان يرجعنى للصفحه اللى قبلها
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'To Do app',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          // الابيض اللى بارز
          Positioned(
            top: 120,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Text(
                    'Edit Task',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black, fontSize: 25),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: widget.task.tittle,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18, color: Colors.black),
                          onChanged: (String? value) {
                            widget.task.tittle = value;
                          },
                          validator: (String? value) {
                            // handle if null
                            if (value!.isEmpty || value == null) {
                              return ' des must be not null';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: widget.task.descrabtion,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18, color: Colors.black),
                          onChanged: (String? value) {
                            widget.task.descrabtion = value;
                          },
                          validator: (String? value) {
                            // handle if null
                            if (value!.isEmpty || value == null) {
                              return ' des must be not null';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Sellect Date',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 20, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      showDateDialoge();
                    },
                    child: Text(
                      '${selectedate.year} / ${selectedate.month} / ${selectedate.day} ',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {
                      // onSubmited();
                      editTask();
                    },
                    minWidth: 255,
                    height: 55,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    color: Theme.of(context).primaryColor,
                    child: const Text(
                      'Save Change',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // فانكشن عشان اما يدوس على الزرار يحفظ التغيرات عن طريق validator
  onSubmited() {
    if (FormKey.currentState!.validate()) {
      print('done');
    }
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

  void editTask() {
    MyDatabase.editScreenDetails(widget.task).then((value) {
      // لو اتحققت
      //provider.refreshTodo();
      Navigator.pop(context);
    }).catchError((onError) {
      // اما يكون فى error
      print(onError);
    });
  }
}
