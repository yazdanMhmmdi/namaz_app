import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/ahkam_details_model.dart';
import 'package:namaz_app/data/repository/ahkam_details_repository.dart';

part 'ahkam_details_event.dart';
part 'ahkam_details_state.dart';

class AhkamDetailsBloc extends Bloc<AhkamDetailsEvent, AhkamDetailsState> {
  AhkamDetailsBloc() : super(AhkamDetailsInitial());
  AhkamDetailsRepository _repository = new AhkamDetailsRepository();
  AhkamDetailsModel _model;
  @override
  Stream<AhkamDetailsState> mapEventToState(
    AhkamDetailsEvent event,
  ) async* {
    if (event is GetAhkamDetails) {
      try {
        yield AhkamDetailsLoading();
        _model = await _repository.getAhkamDetails(event.ahkam_id);
        if (_model.error == "0") {
          yield AhkamDetailsSuccess(ahkamDetailsModel: _model);
        } else {
          yield AhkamDetailsFailure();
        }
      } catch (err) {
        yield AhkamDetailsFailure();
      }
    }
  }
}
