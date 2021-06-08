import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:namaz_app/data/model/marjae_model.dart';
import 'package:namaz_app/data/repository/marjae_repository.dart';

part 'marjae_event.dart';
part 'marjae_state.dart';

class MarjaeBloc extends Bloc<MarjaeEvent, MarjaeState> {
  MarjaeBloc() : super(MarjaeInitial());
  MarjaeRepository _repository = new MarjaeRepository();
  MarjaeModel _model;
  @override
  Stream<MarjaeState> mapEventToState(
    MarjaeEvent event,
  ) async* {
    if (event is GetMarjaeList) {
      yield MarjaeLoading();
      _model = await _repository.getMarjaeItems();
      if (_model.error == "0") {
        yield MarjaeSuccess(marjaeModel: _model);
      } else {
        yield MarjaeFailure();
      }
    }
  }
}
