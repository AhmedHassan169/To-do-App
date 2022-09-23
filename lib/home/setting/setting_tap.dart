import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/My_Them.dart';
import 'package:to_do/generated/l10n.dart';
import 'package:to_do/home/setting/ThemBottomSheet.dart';
import 'package:to_do/home/setting/languageBottomSheet.dart';
import 'package:to_do/provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Setting_tap extends StatefulWidget {
  @override
  State<Setting_tap> createState() => _Setting_tapState();
}

class _Setting_tapState extends State<Setting_tap> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<Setting_provider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.lang,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: (){
              ShowBottomSheetLanguage();
            },
            child: Container(
              width: 320,
              height: 50,
              margin: const EdgeInsets.only(top: 20, left: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: settingsProvider.isDarkMode()
                      ? MyThem.darkScafoldBackground
                      : Colors.white,
                  border: Border.all(
                    color: MyThem.lightPrimary,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    settingsProvider.currentlang =='en' ? 'English' : 'العربيه' ,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 19),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyThem.lightPrimary,
                    size: 26,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 50),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: ShowThemBottomSheet,
            child: Container(
              width: 320,
              height: 50,
              margin: const EdgeInsets.only(top: 20, left: 12),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: settingsProvider.isDarkMode()
                      ? MyThem.darkScafoldBackground
                      : Colors.white,
                  border: Border.all(
                    color: MyThem.lightPrimary,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    settingsProvider.isDarkMode()?AppLocalizations.of(context)!.dark
                    :AppLocalizations.of(context)!.light,


                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 19),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyThem.lightPrimary,
                    size: 26,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ShowThemBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return ThemBottomSheet();
        });
  }
  void ShowBottomSheetLanguage() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return LangugeBottomSheet();
        });
  }

}
