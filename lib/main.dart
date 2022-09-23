import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/My_Them.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/home/home.dart';
import 'package:to_do/provider/setting_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

main() async {
  // هعمل initialization  ل firebase
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider<Setting_provider>(
      create: (buildContext) {
        return Setting_provider();
      },
      child: Myapp()));
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<Setting_provider>(context);

    return MaterialApp(
      title: 'بسم الله الرحمن الرحيم',
      theme: MyThem.light_them,
      darkTheme: MyThem.Dark_them,
      themeMode: settingsProvider
          .currentThem, // هنا قلتلو هاتلى السيم اللى محطوط فى البروفايدر وحطولى لابلكشين كلو
      //كدا بقول للبرنامج انو اجبارا اشتغل ف السيم المعين
      // واروح احطو جوا provider

      initialRoute:
          home_screen.Routname, // دا الاسكرين اللى البرنامج هيبدأ من عندها
      debugShowCheckedModeBanner: false,
      routes: {
        // هنا بعرف كل الاسكرين اللى عندى عشان اربطهم ببعض عشان اعرف اتنقل بينهم
        home_screen.Routname: (_) => home_screen(),


      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // دا اللى بقول جواه احنا عايزين اللغات بتاعتنا هتكون ايه
        Locale('en'), // English, no country code
        Locale('ar'), // Arabic, no country code
      ],
      // local: دا اللى بيفرض اليوزر على استخدام الحاجه هو ايه
       locale: Locale(settingsProvider.currentlang),
    );
  }
}
