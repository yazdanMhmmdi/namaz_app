import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dark_mode_event.dart';
part 'dark_mode_state.dart';

class DarkModeBloc extends Bloc<DarkModeEvent, DarkModeState> {
  DarkModeBloc() : super(DarkModeInitial(isDark: false));
  bool _isDarkMode = false;
  @override
  Stream<DarkModeState> mapEventToState(
    DarkModeEvent event,
  ) async* {
    if (event is DarkModeStatus) {
      if (event.darkModeStatus) {
        _isDarkMode = true;
        yield DarkModeEnable(isDark: _isDarkMode);
      } else {
        _isDarkMode = false;
        yield DarkModeDisable(isDark: _isDarkMode);
      }
    }
  }
}
