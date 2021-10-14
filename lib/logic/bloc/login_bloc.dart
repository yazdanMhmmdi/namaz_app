import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/login_model.dart';
import 'package:namaz_app/data/repository/login_repository.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  LoginRepository _repository = new LoginRepository();
  LoginModel _model;
  SharedPreferences _prefs;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is TryLogin) {
      yield LoginLoading();
      _prefs = await SharedPreferences.getInstance();

      try {
        _model = await _repository.login(event.username, event.password);
        if (_model.error == "0") {
          if (await setSharedPrefes(_model)) {
            GlobalWidget.user_id = _model.userId;
            yield LoginSuccess(userId: _model.userId);
          }
        } else {
          yield LoginFailure();
        }
      } catch (error) {
        yield LoginFailure();
      }
    }
  }

  Stream<LoginState> tryToLogin(LoginEvent event) async* {}

  Future<bool> setSharedPrefes(_model) async {
    return await _prefs.setString("id", _model.userId.toString());
  }
}
