import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dark_mode_event.dart';
part 'dark_mode_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(isDark: false));
  bool _isDarkMode = false;
  SharedPreferences _prefs;
  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is SetDarkModeStatus) {
      if (event.darkModeStatus) {
        _isDarkMode = true;
        setDarkmodeSharedPrefes(_isDarkMode);
        yield DarkModeEnable(isDark: _isDarkMode);
      } else {
        _isDarkMode = false;
        setDarkmodeSharedPrefes(_isDarkMode);
        yield DarkModeDisable(isDark: _isDarkMode);
      }
    } else if (event is GetDarkModeStatus) {
      yield ThemeInitial(isDark: _isDarkMode);

      if (_isDarkMode)
        yield DarkModeEnable(isDark: _isDarkMode);
      else
        yield DarkModeDisable(isDark: _isDarkMode);
    } else if (event is GetDarkModestatusFromLocalStorage) {
      _isDarkMode = await getDarkModeSharedPrefs();
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

  Future<bool> setDarkmodeSharedPrefes(bool darkModeStatus) async {
    _prefs = await SharedPreferences.getInstance();
    return await _prefs.setBool("isDarkMode", darkModeStatus);
  }
}
