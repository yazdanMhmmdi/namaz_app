import 'package:flutter/material.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/presentation/animation/fade_in_animation.dart';
import 'package:namaz_app/presentation/widget/background_shapes.dart';
import 'package:namaz_app/presentation/widget/my_button.dart';
import 'package:namaz_app/presentation/widget/my_text_field.dart';
import 'package:namaz_app/presentation/widget/progress_button.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController usernameController = new TextEditingController();
    ButtonState buttonState = ButtonState.idle;

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
              child: FadeInAnimation(
                0.5,
                Container(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 26),
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
                        MyButton(
                          buttonState: buttonState,
                          text: "ثبت نام",
                          
                          onTap: () {

                          },


                        ),
                      ],
                    ),
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
