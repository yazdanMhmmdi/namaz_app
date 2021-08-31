import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isDark = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "حالت تیره",
                    style: TextStyle(
                      fontFamily: Assets.basicFont,
                      fontSize: 16,
                      color: IColors.black70,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Switch(
                    value: _isDark,
                    onChanged: (bool value) {
                      print(value);
                      isDarkState();
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Divider(),
            ),
            //other vertical items place here.
          ],
        ),
      ),
    );
  }

  void isDarkState() {
    if (_isDark) {
      setState(() {
        _isDark = false;
      });
    } else {
      setState(() {
        _isDark = true;
      });
    }
  }
}
