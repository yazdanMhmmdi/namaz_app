import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';

class MyTextFiled extends StatefulWidget {
  var icon;
  var text;
  var obscureText;
  Color textFieldColor;
  TextEditingController controller;
  MyTextFiled(
      {@required this.controller,
      @required this.obscureText,
      @required this.icon,
      @required this.text,
      @required this.textFieldColor});

  @override
  _MyTextFiledState createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.textFieldColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              IconButton(
                  icon: Icon(widget.icon, color: IColors.iconColor),
                  onPressed: () {}),
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: widget.obscureText,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: Assets.basicFont,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '${widget.text}',
                  ),
                  inputFormatters: [
                    new FilteringTextInputFormatter.allow(
                        RegExp(r'^[a-zA-Z0-9]+$')),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 16),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         border: InputBorder.none,
              //         hintText: 'نام کاربری'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
