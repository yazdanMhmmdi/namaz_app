import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/shohada_details_model.dart';
import 'package:namaz_app/data/repository/shohada_details_repository.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shohada_details_event.dart';
part 'shohada_details_state.dart';

class ShohadaDetailsBloc
    extends Bloc<ShohadaDetailsEvent, ShohadaDetailsState> {
  ShohadaDetailsBloc() : super(ShohadaDetailsInitial());
  ShohadaDetailsRepository _repository = new ShohadaDetailsRepository();
  ShohadaDetailsModel _model;
  String liked = "false";
  SharedPreferences prefs;
  bool featureDiscovery = false;
  @override
  Stream<ShohadaDetailsState> mapEventToState(
    ShohadaDetailsEvent event,
  ) async* {
    if (event is GetShohadaDetails) {
      try {
        yield ShohadaDetailsLoading();
        _model = await _repository.getShohadaDetails(
            event.shohada_id, GlobalWidget.user_id);
        if (_model.error == "0") {
          liked = _model.data.liked.toString();
          await experienceFeatureDiscovery();

          yield ShohadaDetailsSuccess(
            shohadaDetailsModel: _model,
            liked: liked,
            featureDiscovery: featureDiscovery,
          );
        } else {
          yield ShohadaDetailsFailure();
        }
      } catch (err) {
        yield ShohadaDetailsFailure();
      }
    } else if (event is LikeShohada) {
      try {
        await _repository.likeShohada(event.shohada_id, event.user_id);
        if (_model.error == "0") {
          liked = "true";
          yield LikeShohadaSuccess(shohadaDetailsModel: _model, liked: liked);
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    } else if (event is DisLikeShohada) {
      try {
        await _repository.disLikeShohada(event.shohada_id, event.user_id);
        if (_model.error == "0") {
          liked = "false";
          yield LikeShohadaSuccess(shohadaDetailsModel: _model, liked: liked);
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    }
  }

  Future<void> experienceFeatureDiscovery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferences preferences = prefs;

    if (preferences.getString("fav") == null) {
      print("not defined");
      featureDiscovery = true;
      await prefs.setString("fav", "false");
    } else {
      featureDiscovery = false;
      print("defined");
    }
  }
}
