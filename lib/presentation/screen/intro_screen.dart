import 'dart:async';

import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/presentation/widget/background_shapes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      if (await getSharedPrefs() == "") {
        Navigator.pushNamedAndRemoveUntil(context, '/sign_up', (e) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (e) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.purpleCrimson,
      body: Stack(
        children: [
          BackgroundShapes(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(Assets.prayerO),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "این یک متن موقتی",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: IColors.lightBrown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "سازنده یزدان محمدی",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: IColors.lightBrown.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                SizedBox(
                  height: 8,
                ),
                Text(
                  "دانشکده فنی پسران قم",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: IColors.lightBrown.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = "";

    id = (prefs.getString('id') == null ? "" : prefs.getString('id'));
    print('sharedPrefs : $id');

    return id;
  }
}
