import 'dart:async';

import 'package:flutter/material.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/presentation/widget/progress_button.dart';

class MyButton extends StatefulWidget {
  String text;
  Function onTap;
  var buttonState = ButtonState.idle;

  void runAnimation(var state) {
    if (state == ButtonState.loading) {
    } else if (state == ButtonState.success) {
    } else if (state == ButtonState.fail) {
    } else if (state == ButtonState.idle) {}
  }

  MyButton(
      {@required this.text, @required this.onTap, @required this.buttonState});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  double buttonRadius = 8.0;
  double maxWidth;
  bool maxWidthFlag = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (maxWidthFlag) {
        maxWidth = MediaQuery.of(context).size.width;
        maxWidthFlag = false;
      }
    });
    return ProgressButton(
      minWidth: 50.0,
      height: 46.0,
      maxWidth: maxWidth,
      radius: buttonRadius,
      progressIndicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      progressIndicatorAligment: MainAxisAlignment.center,
      stateWidgets: {
        ButtonState.idle: Text(
          "${widget.text}",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "IranSans",
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        ButtonState.loading: Container(),
        ButtonState.fail: Icon(
          Icons.close,
          color: Colors.white,
        ),
        ButtonState.success: Icon(
          Icons.check,
          color: Colors.white,
        )
      },
      stateColors: {
        ButtonState.idle: IColors.brown,
        ButtonState.loading: IColors.brown,
        ButtonState.fail: IColors.brown,
        ButtonState.success: IColors.brown,
      },
      onPressed: () {
        // setState(() {
        //   buttonState = widget.onTap(); //asdsadsdd
        // });
        widget.onTap();
        // else if (widget.buttonState == ButtonState.idle) {
        //   setState(() {
        //     widget.buttonState = ButtonState.idle;
        //     buttonRadius = 8;
        //     maxWidth = MediaQuery.of(context).size.width;
        //   });
        // } else if (widget.buttonState == ButtonState.success) {
        //   setState(() {
        //     widget.buttonState = ButtonState.success;
        //     buttonRadius = 100;
        //     maxWidth = 50.0;
        //   });
        // }
      },
      state: widget.buttonState,
    );
  }
}
