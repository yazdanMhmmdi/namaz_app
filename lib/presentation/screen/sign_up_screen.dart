import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/logic/bloc/sign_up_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/animation/fade_in_animation.dart';
import 'package:namaz_app/presentation/widget/background_shapes.dart';
import 'package:namaz_app/presentation/widget/loading_bar.dart';
import 'package:namaz_app/presentation/widget/my_button.dart';
import 'package:namaz_app/presentation/widget/my_text_field.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
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

  String usernameWarning = "";
  String passwordWarning = "";

  @override
  void initState() {
    authValidatiors();
    super.initState();
  }

  Color backgroundColor = IColors.purpleCrimson;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SignUpBloc, SignUpState>(
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
        ),
        BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected) {
              setState(() {
                backgroundColor = IColors.purpleCrimson;
              });
            } else if (state is InternetDisconnected) {
              setState(() {
                backgroundColor = Colors.white;
              });
            } else {
              setState(() {
                backgroundColor = Colors.white;
              });
            }
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: backgroundColor,
          body: BlocBuilder<InternetCubit, InternetState>(
            builder: (context, state) {
              if (state is InternetConnected) {
                return Stack(
                  children: [
                    Hero(
                        tag: "backgroundShapes",
                        child: BackgroundShapes(
                          isDarkMode: false,
                        )),
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
                                      : WarningBar(text: usernameWarning),
                                  SizedBox(height: 16),
                                  MyTextFiled(
                                      controller: passwordController,
                                      obscureText: true,
                                      icon: Icons.lock,
                                      text: "${Strings.signPassword}",
                                      textFieldColor: IColors.lightBrown),
                                  _passwordStatus
                                      ? Container()
                                      : WarningBar(text: passwordWarning),
                                  SizedBox(height: 16),
                                  MyButton(
                                    buttonState: buttonState,
                                    text: "${Strings.signUp}",
                                    onTap: () {
                                      if (_usernameStatus && _passwordStatus) {
                                        if (usernameController.text.length !=
                                                0 &&
                                            passwordController.text.length !=
                                                0) {
                                          BlocProvider.of<SignUpBloc>(context)
                                              .add(SignUp(
                                                  username:
                                                      usernameController.text,
                                                  password:
                                                      passwordController.text));
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
                );
              } else if (state is InternetDisconnected) {
                return NoNetworkFlare(
                  isDarkMode: false,
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }

  void authValidatiors() {
    usernameController.addListener(() {
      if (usernameController.text.isUsername()) {
        if (usernameController.text.length < 17) {
          if (usernameController.text.length >= 5) {
            print('ready to sign up');
            setState(() {
              _usernameStatus = true;
            });
          } else {
            print('no x');
            print("name karbari nabayad kamtar az 5 raqam bashd");
            setState(() {
              _usernameStatus = false;
              usernameWarning = Strings.usernameErrorFiveCharrecter;
            });
          }
        } else {
          print("name karbari bish az 17 raqam ast");
          setState(() {
            _usernameStatus = false;
            usernameWarning = Strings.usernameErrorSevenTeenCharrecter;
          });
        }
      } else {
        print("name karbari nist");
        setState(() {
          _usernameStatus = false;
          usernameWarning = Strings.usernameErrorIsUsername;
        });
      }
    });

    passwordController.addListener(() {
      if (passwordController.text.isPasswordEasy()) {
        if (passwordController.text.length >= 8) {
          if (passwordController.text.length < 17) {
            setState(() {
              _passwordStatus = true;
            });
          } else {
            setState(() {
              passwordWarning = Strings.passwordErrorSixTeenCharrecter;
              _passwordStatus = false;
            });
          }
        } else {}
      } else {
        print("ramz oboor zaeiif ast");
        setState(() {
          passwordWarning = Strings.passwordErrorIsPassword;
          _passwordStatus = false;
        });
      }
    });
  }
}
