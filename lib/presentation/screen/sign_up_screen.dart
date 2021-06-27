import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/sign_up_bloc.dart';
import 'package:namaz_app/presentation/animation/fade_in_animation.dart';
import 'package:namaz_app/presentation/widget/background_shapes.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/my_button.dart';
import 'package:namaz_app/presentation/widget/my_text_field.dart';
import 'package:namaz_app/presentation/widget/progress_button.dart';
import 'package:namaz_app/presentation/widget/warning_bar.dart';
import 'package:regexpattern/regexpattern.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool _usernameStatus = true;
  bool _passwordStatus = true;

  ButtonState buttonState = ButtonState.idle;

  @override
  void initState() {
    authValidatiors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          setState(() {
            buttonState = ButtonState.loading;
          });
        } else if (state is SignUpSuccess) {
          Timer(Duration(seconds: 2), () {
            setState(() {
              buttonState = ButtonState.success;
            });
          });
          Timer(Duration(seconds: 4), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          });
        } else if (state is SignUpFailure) {
          Timer(Duration(seconds: 2), () {
            setState(() {
              buttonState = ButtonState.fail;
            });
          });
        }
      },
      child: Scaffold(
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
                              text: "${Strings.signUpUsername}",
                              textFieldColor: IColors.lightBrown),
                          _usernameStatus
                              ? Container()
                              : WarningBar(text: Strings.signUpUsernameWarning),
                          SizedBox(height: 16),
                          MyTextFiled(
                              controller: passwordController,
                              obscureText: true,
                              icon: Icons.lock,
                              text: "${Strings.signPassword}",
                              textFieldColor: IColors.lightBrown),
                          _passwordStatus
                              ? Container()
                              : WarningBar(text: Strings.signUpPasswordWarning),
                          SizedBox(height: 16),
                          MyButton(
                            buttonState: buttonState,
                            text: "${Strings.signUp}",
                            onTap: () {
                              if (_usernameStatus && _passwordStatus) {
                                if (usernameController.text.length != 0 &&
                                    passwordController.text.length != 0) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                      SignUp(
                                          username: usernameController.text,
                                          password: passwordController.text));
                                }
                              }
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
      ),
    );
  }

  void authValidatiors() {
    usernameController.addListener(() {
      if (usernameController.text.isUsername() &&
          usernameController.text.length < 17 &&
          usernameController.text.length >= 5) {
        print('ready to sign up');
        setState(() {
          _usernameStatus = true;
        });
      } else {
        print('no');
        setState(() {
          _usernameStatus = false;
        });
      }
    });

    passwordController.addListener(() {
      if (passwordController.text.isPasswordEasy() &&
          passwordController.text.length >= 8 &&
          passwordController.text.length < 17) {
        setState(() {
          _passwordStatus = true;
        });
      } else {
        setState(() {
          _passwordStatus = false;
        });
      }
    });
  }
}
