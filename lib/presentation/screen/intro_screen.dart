import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';




class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(

        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Image.asset(Assets.topLeftShape),
          ),
        ],
      ),
      
    );
  }
}