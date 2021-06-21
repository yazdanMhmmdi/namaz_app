import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/ahkam_details_model.dart';
import 'package:namaz_app/data/model/like_ahkam_model.dart';
import 'package:namaz_app/data/repository/ahkam_details_repository.dart';

part 'ahkam_details_event.dart';
part 'ahkam_details_state.dart';

class AhkamDetailsBloc extends Bloc<AhkamDetailsEvent, AhkamDetailsState> {
  AhkamDetailsBloc() : super(AhkamDetailsInitial());
  AhkamDetailsRepository _repository = new AhkamDetailsRepository();
  AhkamDetailsModel _model;
  LikeAhkamModel _likeAhkamModel;
  String liked = "false";
  @override
  Stream<AhkamDetailsState> mapEventToState(
    AhkamDetailsEvent event,
  ) async* {
    if (event is GetAhkamDetails) {
      try {
        yield AhkamDetailsLoading();
        _model =
            await _repository.getAhkamDetails(event.ahkam_id, event.user_id);
        if (_model.error == "0") {
          liked = _model.data.liked.toString();
          yield AhkamDetailsSuccess(ahkamDetailsModel: _model, liked: liked);
        } else {
          yield AhkamDetailsFailure();
        }
      } catch (err) {
        yield AhkamDetailsFailure();
      }
    } else if (event is LikeAhkam) {
      try {
        _likeAhkamModel =
            await _repository.likeAhkam(event.ahkam_id, event.user_id);
        if (_model.error == "0") {
          liked = "true";
          yield LikeAhkamSuccess(ahkamDetailsModel: _model, liked: liked);
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    } else if (event is DisLikeAhkam) {
      try {
        _likeAhkamModel =
            await _repository.disLikeAhkam(event.ahkam_id, event.user_id);
        if (_model.error == "0") {
          liked = "false";
          yield LikeAhkamSuccess(ahkamDetailsModel: _model, liked: liked);
        } else {
          // yield LikeAhkamFailure();
        }
      } catch (err) {
        // yield LikeAhkamFailure();
      }
    }
  }
}
