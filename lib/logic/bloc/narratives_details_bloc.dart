import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/like_narratives_model.dart';
import 'package:namaz_app/data/model/narratives_details_screen.dart';
import 'package:namaz_app/data/repository/narratives_details_repository.dart';
import 'package:namaz_app/presentation/widget/global_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'narratives_details_event.dart';
part 'narratives_details_state.dart';

class NarrativesDetailsBloc
    extends Bloc<NarrativesDetailsEvent, NarrativesDetailsState> {
  NarrativesDetailsBloc() : super(NarrativesDetailsInitial());

  NarrativesDetailsRepository _repository = new NarrativesDetailsRepository();
  NarrativesDetailsModel _model;
  LikeNarrativesModel _likeNarrativesModel;
  String liked = "false";

  @override
  Stream<NarrativesDetailsState> mapEventToState(
    NarrativesDetailsEvent event,
  ) async* {
    if (event is GetNarrativesDetails) {
      try {
        yield NarrativesDetailsLoading();
        _model = await _repository.getNarrativesDetails(
            event.narratives_id, GlobalWidget.user_id);
        if (_model.error == "0") {
          liked = _model.data.liked.toString();
          yield NarrativesDetailsSuccess(
              narrativesDetailsModel: _model, liked: liked);
        } else {
          yield NarrativesDetailsFailure();
        }
      } catch (err) {
        yield NarrativesDetailsFailure();
      }
    } else if (event is LikeNarratives) {
      try {
        _likeNarrativesModel =
            await _repository.likeAhkam(event.narratives_id, event.user_id);
        if (_model.error == "0") {
          liked = "true";
          yield LikeNarrativesSuccess(
              narrativesDetailsModel: _model, liked: liked);
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    } else if (event is DisLikeNarratives) {
      try {
        _likeNarrativesModel =
            await _repository.disLikeAhkam(event.narratives_id, event.user_id);
        if (_model.error == "0") {
          liked = "false";
          yield LikeNarrativesSuccess(
              narrativesDetailsModel: _model, liked: liked);
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    }
  }

  // Future<void> experienceFeatureDiscovery() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   SharedPreferences preferences = prefs;

  //   if (preferences.getString("fav") == null) {
  //     print("not defined");
  //     featureDiscovery = true;
  //     await prefs.setString("fav", "false");
  //   } else {
  //     featureDiscovery = false;
  //     print("defined");
  //   }
  // }
}
