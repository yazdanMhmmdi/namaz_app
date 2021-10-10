import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/constants/values.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

part 'showcase_event.dart';
part 'showcase_state.dart';

class ShowcaseBloc extends Bloc<ShowcaseEvent, ShowcaseState> {
  ShowcaseBloc() : super(ShowcaseInitial());
  SharedPreferences _prefs;

  @override
  Stream<ShowcaseState> mapEventToState(
    ShowcaseEvent event,
  ) async* {
    if (event is ShowcaseSettings) {
      try {
        // setShowcaseSharedPrefs("showcase_settings", false);
        yield* _runIfShowcaseIsValid("showcase_settings", event);
      } catch (err) {}
    } else if (event is ShowcaseFavorite) {
      try {
        // await setShowcaseSharedPrefs("showcase_favorite_page", false);
        yield* _runIfShowcaseIsValid("showcase_favorite_page", event);
      } catch (error) {}
    } else if (event is ShowcaseFavoriteItem) {
      try {
        await setShowcaseSharedPrefs("showcase_favorite_item", false);
        yield* _runIfShowcaseIsValid("showcase_favorite_item", event);
      } catch (error) {}
    }
  }

  Stream<ShowcaseState> _runIfShowcaseIsValid(
      String preferenceName, var event) async* {
    String prefName = preferenceName;

    if (!await getShowcaseSharedPrefs(prefName)) {
      //Start showcase view after current widget frames are drawn.
      Timer(Duration(milliseconds: Values.showcaseAnimationStartSpeed), () {
        ShowCaseWidget.of(event.buildContext).startShowCase(event.keys);
      });
      yield ShowcaseResult(isShowcase: true);
      await setShowcaseSharedPrefs(prefName, true);
    } else {
      yield ShowcaseResult(isShowcase: false);
    }
  }

  Future<bool> setShowcaseSharedPrefs(String prefName, bool isShowed) async {
    _prefs = await SharedPreferences.getInstance();
    return await _prefs.setBool("${prefName}", isShowed);
  }

  Future<bool> getShowcaseSharedPrefs(String prefName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showcaseResult = false;

    showcaseResult = (prefs.getBool('${prefName}') == null
        ? false
        : prefs.getBool('${prefName}'));
    return showcaseResult;
  }
}
