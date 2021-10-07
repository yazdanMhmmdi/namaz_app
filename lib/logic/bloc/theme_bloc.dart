import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(isDark: false, fontSize: 0));
  bool _isDarkMode = false;
  double _fontSize = 0;
  SharedPreferences _prefs;
  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is SetThemeStatus) {
      if (event.darkModeStatus) {
        _isDarkMode = true;
        _fontSize = event.fontSize;
        setThemeSharedPrefes(_isDarkMode, _fontSize);
        yield DarkModeEnable(isDark: _isDarkMode, fontSize: _fontSize);
      } else {
        _isDarkMode = false;
        _fontSize = event.fontSize;
        setThemeSharedPrefes(_isDarkMode, _fontSize);
        yield DarkModeDisable(isDark: _isDarkMode, fontSize: _fontSize);
      }
    } else if (event is GetThemeStatus) {
      yield ThemeInitial(isDark: _isDarkMode, fontSize: _fontSize);

      if (_isDarkMode)
        yield DarkModeEnable(isDark: _isDarkMode, fontSize: _fontSize);
      else
        yield DarkModeDisable(isDark: _isDarkMode, fontSize: _fontSize);
    } else if (event is GetThemeStatusFromLocalStorage) {
      _isDarkMode = await getDarkModeSharedPrefs();
      _fontSize = await getFontSizeSharedPrefs();
    }
  }

  Future<bool> getDarkModeSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkModeStatus = false;

    darkModeStatus = (prefs.getBool('isDarkMode') == null
        ? false
        : prefs.getBool('isDarkMode'));
    return darkModeStatus;
  }

  Future<double> getFontSizeSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double fontSize = 0;

    fontSize =
        (prefs.getDouble('fontSize') == null ? 0 : prefs.getBool('fontSize'));
    return fontSize;
  }

  Future<bool> setThemeSharedPrefes(
      bool darkModeStatus, double fontSize) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setDouble("fontSize", fontSize);
    return await _prefs.setBool("isDarkMode", darkModeStatus);
  }
}
