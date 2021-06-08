import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
          _model = await _repository.getShohadaItems(page.toString());
          if (_model.shohadaBozorgan.length == 0) {
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield ShohadaSuccess(shohadaModel: _model);
          }
        } else if (page <= totalPage) {
          ShohadaModel _tempModel =
              await _repository.getShohadaItems(page.toString());
          _tempModel.shohadaBozorgan.forEach((element) {
            _model.shohadaBozorgan.add(element);
          });
          page++;
          yield ShohadaSuccess(shohadaModel: _model);
        }
      } catch (err) {
        yield ShohadaFailure();
      }
    }
  }
}
