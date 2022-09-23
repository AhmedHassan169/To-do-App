import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/My_Them.dart';
import 'package:to_do/provider/setting_provider.dart';

class LangugeBottomSheet extends StatefulWidget {
  @override
  State<LangugeBottomSheet> createState() => _LangugeBottomSheetState();
}

class _LangugeBottomSheetState extends State<LangugeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<Setting_provider>(context);
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              settingsProvider.changelanguage('en');
            },
            child: settingsProvider.currentlang == 'en'
                ? getSelectedRow('English')
                : getUnSelectedRow('English'),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              settingsProvider.changelanguage('ar');
            },
            child: settingsProvider.currentlang == 'ar'
                ? getSelectedRow('العربيه')
                : getUnSelectedRow('العربيه'),
          ),
        ],
      ),
    );
  }

  Widget getSelectedRow(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(color: Colors.grey.shade400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 24, color: Colors.black),
          ),
          Icon(
            Icons.check,
            size: 26,
            color: MyThem.lightPrimary,
          ),
        ],
      ),
    );
  }

  Widget getUnSelectedRow(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 24,
                ),
          ),
        ],
      ),
    );
  }
}
