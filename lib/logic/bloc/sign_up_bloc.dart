import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/sign_up_model.dart';
import 'package:namaz_app/data/repository/sign_up_repository.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());
  SignUpRepository _repository = new SignUpRepository();
  SharedPreferences _prefs;
  SignUpModel _model;
  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUp) {
      _prefs = await SharedPreferences.getInstance();

      try {
        yield SignUpLoading();

        _model = await _repository.signUp(event.username, event.password);

        if (_model.error == "0") {
          if (await setSharedPrefes(_model)) {
            //executing shared prefs and test input
            print('setting sign up sharedPrefs successfully');
            final SharedPreferences p = _prefs;
            print("recoverd sharedPrefs: ${p.getString("id")}");
            GlobalWidget.user_id = _model.userId;
          }
          yield SignUpSuccess(user_id: _model.userId);
        } else {
          yield SignUpFailure();
        }
      } catch (e) {
        yield SignUpFailure();
        print('sign up failure ${e.toString()}');
      }
    }
  }

  Future<bool> setSharedPrefes(_model) async {
    return await _prefs.setString("id", _model.userId.toString());
  }
}
