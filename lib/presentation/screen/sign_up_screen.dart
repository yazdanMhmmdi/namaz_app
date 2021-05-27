import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/presentation/widget/background_shapes.dart';
import 'package:namaz_app/presentation/widget/my_text_field.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController usernameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IColors.purpleCrimson,
      body: Stack(
        children: [
          BackgroundShapes(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: IColors.black25,
                        blurRadius: 8,
                        offset: Offset(2, 2),
                      )
                    ]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyTextFiled(
                          controller: usernameController,
                          obscureText: false,
                          icon: Icons.person,
                          text: "نام کاربری...",
                          textFieldColor: IColors.lightBrown),
                      SizedBox(height: 16),
                      MyTextFiled(
                          controller: usernameController,
                          obscureText: false,
                          icon: Icons.person,
                          text: "رمز عبور...",
                          textFieldColor: IColors.lightBrown),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: IColors.brown,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print("xxx");
                            },
                            child: Center(
                              child: Text(
                                "ثبت نام",
                                style: TextStyle(
                                    fontFamily: Assets.basicFont,
                                    color: IColors.white85,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
