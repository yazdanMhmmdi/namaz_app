import 'dart:async';

import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/presentation/widget/background_shapes.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      Navigator.pushNamedAndRemoveUntil(context, '/sign_up', (e) => false);
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
        ],
      ),
    );
  }
}
