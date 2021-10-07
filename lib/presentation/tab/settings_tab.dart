import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/theme_bloc.dart';
import 'package:namaz_app/presentation/widget/font_size_button_widget.dart';
import 'package:namaz_app/presentation/widget/font_size_indicator_widget.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isDarkMode = false;
  ThemeBloc _themeBloc;
  double fontSize = 2;
  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    _themeBloc.add(GetThemeStatus());
    super.initState();
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
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                  Switch(
                    value: _isDarkMode,
                    activeColor: IColors.darkLightPink,
                    onChanged: (bool value) {
                      isDarkState(value);
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
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
                  Row(
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
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
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
