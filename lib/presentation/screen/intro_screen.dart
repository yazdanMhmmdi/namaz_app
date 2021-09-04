import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/dark_mode_bloc.dart';
import 'package:namaz_app/logic/cubit/internet_cubit.dart';
import 'package:namaz_app/presentation/widget/background_shapes.dart';
import 'package:namaz_app/presentation/widget/no_network_flare.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    _darkModeBloc = BlocProvider.of<DarkModeBloc>(context);
    _darkModeBloc
        .add(GetDarkModestatusFromLocalStorage()); //initialize dark mode
    _darkModeBloc.add(GetDarkModeStatus()); //get dark mode status
    super.initState();
  }

  Color backgroundColor = IColors.purpleCrimson;
  DarkModeBloc _darkModeBloc;
  bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<DarkModeBloc, DarkModeState>(
      listener: (context, state) {
        darkModeStateFunction(state);
      },
      child: Scaffold(
          backgroundColor:
              _isDarkMode ? IColors.darkBackgroundColor : backgroundColor,
          body: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is InternetConnected) {
                setState(() {
                  backgroundColor = _isDarkMode
                      ? IColors.darkBackgroundColor
                      : IColors.purpleCrimson;
                });
                Timer(Duration(seconds: 3), () async {
                  if (await getSharedPrefs() == "") {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/sign_up', (e) => false);
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', (e) => false);
                  }
                });
              } else if (state is InternetDisconnected) {
                setState(() {
                  backgroundColor =
                      _isDarkMode ? IColors.darkBackgroundColor : Colors.white;
                });
              } else {
                setState(() {
                  backgroundColor =
                      _isDarkMode ? IColors.darkBackgroundColor : Colors.white;
                });
              }
            },
            builder: (context, state) {
              if (state is InternetConnected) {
                return Stack(
                  children: [
                    Hero(
                        tag: "backgroundShapes",
                        child: BackgroundShapes(
                          isDarkMode: _isDarkMode,
                        )),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(_isDarkMode
                                ? Assets.prayerODark
                                : Assets.prayerO),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            Strings.appName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: IColors.lightBrown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            Strings.appAuthor,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: IColors.lightBrown.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            Strings.authorCollege,
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
                );
              } else if (state is InternetDisconnected) {
                return NoNetworkFlare();
              } else {
                return Container();
              }
            },
          )),
    );
  }

  Future<String> getSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = "";

    id = (prefs.getString('id') == null ? "" : prefs.getString('id'));
    print('sharedPrefs : $id');

    return id;
  }

  void darkModeStateFunction(DarkModeState state) {
    if (state is DarkModeInitial) {
      setState(() {
        _isDarkMode = state.isDark;
      });
    }
    if (state is DarkModeEnable) {
      setState(() {
        _isDarkMode = state.isDark;
      });
    } else if (state is DarkModeDisable) {
      setState(() {
        _isDarkMode = state.isDark;
      });
    }
  }
}
