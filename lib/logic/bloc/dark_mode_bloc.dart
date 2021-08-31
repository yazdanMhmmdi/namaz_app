import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'dark_mode_event.dart';
part 'dark_mode_state.dart';

class DarkModeBloc extends Bloc<DarkModeEvent, DarkModeState> {
  DarkModeBloc() : super(DarkModeInitial());

  @override
  Stream<DarkModeState> mapEventToState(
    DarkModeEvent event,
  ) async* {
    if (event is DarkModeStatus) {
      yield DarkModeInitial();
      if (event.darkModeStatus) {
        yield DarkModeEnable();
      } else {
        yield DarkModeDisable();
      }
    }
  }
}
