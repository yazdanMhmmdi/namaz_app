import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/shohada_details_model.dart';
import 'package:namaz_app/data/repository/shohada_details_repository.dart';

part 'shohada_details_event.dart';
part 'shohada_details_state.dart';

class ShohadaDetailsBloc
    extends Bloc<ShohadaDetailsEvent, ShohadaDetailsState> {
  ShohadaDetailsBloc() : super(ShohadaDetailsInitial());
  ShohadaDetailsRepository _repository = new ShohadaDetailsRepository();
  ShohadaDetailsModel _model;
  @override
  Stream<ShohadaDetailsState> mapEventToState(
    ShohadaDetailsEvent event,
  ) async* {
    if (event is GetShohadaDetails) {
      try {
        yield ShohadaDetailsLoading();
        _model = await _repository.getShohadaDetails(event.shohada_id);
        if (_model.error == "0") {
          yield ShohadaDetailsSuccess(shohadaDetailsModel: _model);
        } else {
          yield ShohadaDetailsFailure();
        }
      } catch (err) {
        yield ShohadaDetailsFailure();
      }
    }
  }
}
