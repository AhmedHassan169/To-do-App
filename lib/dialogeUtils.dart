// عملت الكلاس دا عشان استخدمو فى عرض المسدجات اما يحصل اى اكشن
/// مهمه اوى الفانكشن دى بتخليني اعرض Dialoge وفيه زرارين اختيارى لو عايز احطهم ذى مثلا yes w no

import 'package:flutter/material.dart';

void showmessage(BuildContext context, String message,
    {
    // ( اللى هى ok)
    String? posActionName,
    // دى بترجع فانكشن فويد يعني معندهاش ارجيومنت ومش بترجع داتا
    // هستخدمها فى حاله لو عايز اكشن كمان يتعمل ( اللى هى اما ادوس على ok يطلع)
    VoidCallback? postAction,

    /// ممكن اخليها الاولى تبقي yes والتانيه no
    String? nagActionName,
    VoidCallback? nagAction,
    //هعمل عشان اجبر اليوزر انو مش هيقفل dialog غير اما يختار حاجه
    bool isCancle = true}) {
  // عملت list عشان امررها ل action علطول تحت
  List<Widget> action = [];
  // لو PosActionName مبعوت فى الفانكشن وانا بستدعيها فى bottomsheet
  if (posActionName != null) {
    // ضيفلى button
    action.add(TextButton(
        onPressed: () {
          Navigator.pop(context); //اقفل
          // هستخدمها لو عايز اعمل كمان اكشن همررها هناك فى bottomsheet
          if (postAction != null) {
            postAction();
          }
        },
        child: Text(posActionName)));
  }
  if (nagActionName != null) {
    // لو PosActionName مبعوت فى الفانكشن وانا بستدعيها فى bottomsheet
    action.add(TextButton(
        onPressed: () {
          Navigator.pop(context); //اقفل
          // هستخدمها لو عايز اعمل كمان اكشن همررها هناك فى bottomsheet
          if (nagAction != null) {
            nagAction();
          }
        },
        child: Text(nagActionName)));
  }

// هنادى على فانكشن اسمها showDialog اللى بتطلع dialoge
  showDialog(
      context: context,
      builder: (buildContext) {
        return
            // اللى بيطلع
            AlertDialog(
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: action,
        );
      }
      // دى بتاعت ان بجبر اليوزر مخرجش الا اما الداتا تتعرض
      ,
      barrierDismissible: isCancle);
}

// هعمل فانكشن تانيه عشان استخدمها فى عرض showloading
// هعمل فيها براميتر اختيارى عشان اجبر اليوزر مش يقفل الا اما loading تخلص
void ShowLoding(BuildContext context, String loadingmessage,
    {bool isCancle = true}) {
  showDialog(
      context: context,
      builder: (buildContext) {
        return
            // اللى بيطلع
            AlertDialog(
                content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(loadingmessage , style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ));
      },
      // دى بتاعت ان بجبر اليوزر مخرجش الا اما التحميل يخلص
      barrierDismissible: isCancle);
}

// عشان استدعيها اما اكون عايز اخرج برا اجبارى عشان اما يخلص
void hideLoading(BuildContext context) {
  Navigator.pop(context);
}
