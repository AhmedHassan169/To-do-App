import 'package:flutter/material.dart';

// عملت provider عشان اغير اللغه او السيم من مكان واخد فا يغير الابلكشين كلو
// ignore: camel_case_types
class Setting_provider extends ChangeNotifier {
// هحط الداتا اللى بتتغير

  String currentlang = 'en'; // هفترض ان عندى استرينج ب اللفه دى

  ThemeMode currentThem = ThemeMode.light; // هفترض ان عندى سيم مود نهارى

//

// هعمل فانكشن تساعدنا نعمل chek بيها لو السيم ب دارك
  bool isDarkMode() {
    return currentThem == ThemeMode.dark;
  }

  void changeThem(ThemeMode newthem) {
    if (newthem == currentThem)
      // لو اصلا الغه اللى مخترها هى اللى موجوده
      return;
    currentThem = newthem;
    notifyListeners();
    // اما الداتا بتتغير هقول لباقى الويتجت او الاسكرين ان الدتا اتغيرت
    // متعملش حاجه
  }

  void changelanguage(String newLanguage) {
    // هعمل ميثود عشان اغير اللغه بيه
    if (currentlang == newLanguage)
      // لو اصلا الغه اللى مخترها هى اللى موجوده
      return; // متعملش حاجه

    currentlang = newLanguage;
    notifyListeners(); // اما الداتا بتتغير هقول لباقى الويتجت او الاسكرين ان الدتا اتغيرت
  }
//   String getMainBackGround() {
//     // هعمل فانكشن بتشيك بيها على الباكجورند لو دارك يرجع الاولى لا رجع التانيه
//     return isDarkMode()
//         ? 'assets/images/back_ground_dark.png'
//         : 'assets/images/back_ground.png';
}
