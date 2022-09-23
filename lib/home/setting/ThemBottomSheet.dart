import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/My_Them.dart';
import 'package:to_do/provider/setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemBottomSheet extends StatefulWidget {
  @override
  State<ThemBottomSheet> createState() => _ThemBottomSheetState();
}

class _ThemBottomSheetState extends State<ThemBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<Setting_provider>(context);
    return Container(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              settingsProvider.changeThem(ThemeMode.light);
            },
            child: settingsProvider.isDarkMode()
                ? getUnSelectedRow(AppLocalizations.of(context)!.light)
                : getSelectedRow(AppLocalizations.of(context)!.light),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              settingsProvider.changeThem(ThemeMode.dark);
            },
            child: settingsProvider.isDarkMode()
                ? getSelectedRow(AppLocalizations.of(context)!.dark)
                : getUnSelectedRow(AppLocalizations.of(context)!.dark),
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
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 24,
              color: Colors.black
                ),
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
