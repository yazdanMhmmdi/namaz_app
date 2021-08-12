import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:namaz_app/data/model/shohada_model.dart';
import 'package:namaz_app/data/repository/shohada_repository.dart';

part 'shohada_event.dart';
part 'shohada_state.dart';

class ShohadaBloc extends Bloc<ShohadaEvent, ShohadaState> {
  ShohadaBloc() : super(ShohadaInitial());
  ShohadaRepository _repository = new ShohadaRepository();
  ShohadaModel _model;
  int page = 1;
  int totalPage;
  @override
  Stream<ShohadaState> mapEventToState(
    ShohadaEvent event,
  ) async* {
    if (event is GetShohadaList) {
      try {
        if (page == 1) {
          yield ShohadaLoading();

          _model =
              await _repository.getShohadaItems(page.toString(), event.search);
          if (_model.shohadaBozorgan.length == 0) {
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield ShohadaSuccess(shohadaModel: _model);
          }
        } else if (page <= totalPage) {
          ShohadaLazyLoading(shohadaModel: _model);
          ShohadaModel _tempModel =
              await _repository.getShohadaItems(page.toString(), event.search);
          _tempModel.shohadaBozorgan.forEach((element) {
            _model.shohadaBozorgan.add(element);
          });
          page++;
          yield ShohadaSuccess(shohadaModel: _model);
        } else if (page > totalPage) {
          yield ShohadaListCompleted(shohadaModel: _model);
        }
      } catch (err) {
        yield ShohadaFailure();
      }
    } else if (event is SearchShohadaItems) {
      try {
        page = 1;
        _model = new ShohadaModel();
        if (page == 1) {
          yield ShohadaSearchLoading();
          _model =
              await _repository.getShohadaItems(page.toString(), event.search);
          if (_model.shohadaBozorgan.length == 0) {
            yield ShohadaSearchEmpty(shohadaModel: _model);
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield ShohadaSuccess(shohadaModel: _model);
          }
        } else if (page <= totalPage) {
          ShohadaLazyLoading(shohadaModel: _model);
          ShohadaModel _tempModel =
              await _repository.getShohadaItems(page.toString(), event.search);
          _tempModel.shohadaBozorgan.forEach((element) {
            _model.shohadaBozorgan.add(element);
          });
          page++;
          yield ShohadaSuccess(shohadaModel: _model);
        } else if (page > totalPage) {
          yield ShohadaListCompleted(shohadaModel: _model);
        }
      } catch (err) {
        yield ShohadaFailure();
      }
    }
  }
}
