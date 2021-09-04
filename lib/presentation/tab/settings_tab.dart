import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namaz_app/constants/assets.dart';
import 'package:namaz_app/constants/colors.dart';
import 'package:namaz_app/constants/strings.dart';
import 'package:namaz_app/logic/bloc/dark_mode_bloc.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isDarkMode = false;
  DarkModeBloc _darkModeBloc;
  @override
  void initState() {
    _darkModeBloc = BlocProvider.of<DarkModeBloc>(context);
    _darkModeBloc.add(GetDarkModeStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DarkModeBloc, DarkModeState>(
        listener: (context, state) {
      darkModeStateFunction(state);
    }, builder: (cotnext, state) {
      if (state is DarkModeInitial) {
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
                    "حالت تیره",
                    style: TextStyle(
                      fontFamily: Assets.basicFont,
                      fontSize: 16,
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
    _darkModeBloc.add(SetDarkModeStatus(darkModeStatus: _isDarkMode));
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
