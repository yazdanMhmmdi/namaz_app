import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/ahkam_model.dart';
import 'package:namaz_app/data/repository/ahkam_repository.dart';

part 'ahkam_event.dart';
part 'ahkam_state.dart';

class AhkamBloc extends Bloc<AhkamEvent, AhkamState> {
  AhkamBloc() : super(AhkamInitial());
  AhkamRepository _repository = new AhkamRepository();
  AhkamModel _model;
  int page = 1;
  int totalPage;
  @override
  Stream<AhkamState> mapEventToState(
    AhkamEvent event,
  ) async* {
    if (event is GetAhkamItems) {
      try {
        if (page == 1) {
          yield AhkamLoading();

          _model =
              await _repository.getAhkamItems(event.marjae_id, page.toString());
          if (_model.ahkam.length == 0) {
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield AhkamSuccess(ahkamModel: _model);
          }
        } else if (page <= totalPage) {
          yield AhkamLazyLoading(ahkamModel: _model);
          AhkamModel _tempModel =
              await _repository.getAhkamItems(event.marjae_id, page.toString());
          _tempModel.ahkam.forEach((element) {
            _model.ahkam.add(element);
          });
          page++;
          yield AhkamSuccess(ahkamModel: _model);
        } else if (page > totalPage) {
          yield AhkamListCompleted(ahkamModel: _model);
        }
      } catch (err) {
        yield AhkamFailure();
      }
    }
  }
}
