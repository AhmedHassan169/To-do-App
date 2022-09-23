// هعمل كلاس لكل داتا لوحدها عشان اتعامل مع الاوبجكت اللى فيها بالفايربيز

// ignore_for_file: non_constant_identifier_names

class Task {
  /// 1- بعرف ال attribute
  static const String collectionName =
      'name'; // اسم مجموعه التاسكك عشان اتعامل بيها مره واحده
  String? id;
  String? tittle;
  String? descrabtion;
  DateTime? dateTime;
  bool? isDone; // هعمل تشيك بيها ان اكلاس اذا كانت اتنفذت ولا لا
  ///2- بعمل constructor عشان يشيل attribute
  // وخليتهم required
  Task({this.id, this.tittle, this.descrabtion, this.dateTime, this.isDone});

  /// 3- بعمل فانكشن عشان اجيب الداتا من Firebase عشان احولها ل اوبجكت من نوع task فى الانكشن التانيه

  Task.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          tittle: data['tittle'],
          descrabtion: data['descrabtion'],
          dateTime: DateTime.fromMicrosecondsSinceEpoch(
              data['dateTime']) // عشام اقولو رجعهالى رقم
          ,
          isDone: data['isDone'],
        );

  ///4- فانكشن عشان نحول الاوبجكت ل map

  Map<String, dynamic> toFireStore() {
    // هترجع map
    return {
      // عباره عن key :value
      'id': id,
      'tittle': tittle,
      'descrabtion': descrabtion,
      'dateTime':
      dateTime?.microsecondsSinceEpoch, // عشان اقولو خزنهولى على هيأته رقم
      'isDone': isDone
    };
  }
}
