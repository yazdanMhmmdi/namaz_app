import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/presentation/widget/font_size_button_widget.dart';
import 'package:namaz_app/presentation/widget/font_size_indicator_widget.dart';
import 'package:namaz_app/presentation/widget/showcase_helper_widget.dart';
import 'package:showcaseview/showcaseview.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isDarkMode = false;
  ThemeBloc _themeBloc;
  double fontSize = 2;
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();

  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _themeBloc.add(GetThemeStatus());
    super.initState();
    //Start showcase view after current widget frames are drawn.
    Timer(Duration(milliseconds: Values.showcaseAnimationStartSpeed), () {
      ShowCaseWidget.of(context).startShowCase([
        _one,
        _two,
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(listener: (context, state) {
      themeStateFunction(state);
    }, builder: (cotnext, state) {
      if (state is ThemeInitial) {
        return getSettingsUI(isDark: false);
      } else if (state is DarkModeDisable) {
        return getSettingsUI(isDark: false);
      } else if (state is DarkModeEnable) {
        return getSettingsUI(isDark: true);
      }
    });
  }

  Widget getSettingsUI({bool isDark}) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.settingsDarkMode,
                      style: TextStyle(
                        fontFamily: Assets.basicFont,
                        fontSize: 16 + fontSize,
                        color: isDark ? IColors.darkWhite70 : IColors.black70,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ShowcaseHelperWidget(
                      text: Strings.showcaseSwitchGuide,
                      key: _one,
                      duration: Duration(
                          milliseconds:
                              Values.showcaseAnimationTransitionSpeed),
                      showcaseBackgroundColor: IColors.white85,
                      fontSize: fontSize,
                      child: Switch(
                        value: _isDarkMode,
                        activeColor: IColors.darkLightPink,
                        onChanged: (bool value) {
                          isDarkState(value);
                        },
                      ),
                    ),
                    // Showcase(
                    //   description: Strings.showcaseSwitchGuide,
                    //   key: _one,
                    //   animationDuration: Duration(
                    //       milliseconds:
                    //           Values.showcaseAnimationTransitionSpeed),
                    //   showcaseBackgroundColor: IColors.white85,
                    //   descTextStyle: TextStyle(
                    //       fontSize: 16 + fontSize, color: IColors.black70),
                    //   child: Switch(
                    //     value: _isDarkMode,
                    //     activeColor: IColors.darkLightPink,
                    //     onChanged: (bool value) {
                    //       isDarkState(value);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.settingsFontSize,
                      style: TextStyle(
                        fontFamily: Assets.basicFont,
                        fontSize: 16 + fontSize,
                        color: isDark ? IColors.darkWhite70 : IColors.black70,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ShowcaseHelperWidget(
                        key: _two,
                        text: Strings.showcaseFontSizeGuide,
                        duration: Duration(
                            milliseconds:
                                Values.showcaseAnimationTransitionSpeed),
                        showcaseBackgroundColor: IColors.white85,
                        fontSize: fontSize,
                        child: Row(
                          children: [
                            FontSizeButtonWidget(
                              isDarkMode: isDark,
                              onTap: () => bolderFontSize(),
                              icon: Icon(
                                Icons.add,
                                size: 16,
                                color: IColors.white85,
                              ),
                            ),
                            FontSizeIndicatorWidget(
                                isDarkMode: isDark,
                                text: fontSize == 2
                                    ? Strings.settingsFontSizelarge
                                    : fontSize == 0
                                        ? Strings.settingsFontSizeMedium
                                        : Strings.settingsFontSizeSmall),
                            FontSizeButtonWidget(
                              isDarkMode: isDark,
                              onTap: () => thinnerFontSize(),
                              icon: Icon(
                                Icons.remove,
                                size: 16,
                                color: IColors.white85,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Divider(
                color: _isDarkMode ? IColors.darkWhite25 : IColors.black25,
              ),
            ),
            //other vertical items place here.
          ],
        ),
      ),
    );
  }

  void isDarkState(value) {
    if (value) {
      setState(() {
        _isDarkMode = true;
      });
    } else {
      setState(() {
        _isDarkMode = false;
      });
    }
    _themeBloc
        .add(SetThemeStatus(darkModeStatus: _isDarkMode, fontSize: fontSize));
  }

  void themeStateFunction(ThemeState state) {
    if (state is ThemeInitial) {
      setState(() {
        _isDarkMode = state.isDark;
        fontSize = state.fontSize;
      });
    }
    if (state is DarkModeEnable) {
      setState(() {
        _isDarkMode = state.isDark;
        fontSize = state.fontSize;
      });
    } else if (state is DarkModeDisable) {
      setState(() {
        _isDarkMode = state.isDark;
        fontSize = state.fontSize;
      });
    }
  }

  void bolderFontSize() {
    setState(() {
      if (fontSize == -2) {
        fontSize += 2;
      } else if (fontSize == 0) {
        fontSize += 2;
      }
    });
    _themeBloc
        .add(SetThemeStatus(darkModeStatus: _isDarkMode, fontSize: fontSize));
  }

  void thinnerFontSize() {
    setState(() {
      if (fontSize == 2) {
        fontSize -= 2;
      } else if (fontSize == 0) {
        fontSize -= 2;
      }
    });
    _themeBloc
        .add(SetThemeStatus(darkModeStatus: _isDarkMode, fontSize: fontSize));
  }
}
