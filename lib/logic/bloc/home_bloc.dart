import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:namaz_app/data/model/home_model.dart';
import 'package:namaz_app/data/repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());
  HomeRepository _repository = new HomeRepository();
  HomeModel _model = HomeModel();
  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is GetHomeItemsEvent) {
      try {
        yield HomeLoading();
        _model = await _repository.getHomeItems();
        if (_model.error == "0") {
          yield HomeSuccess(homeModel: _model);
        } else {
          yield HomeFailure();
        }
      } catch (err) {
        yield HomeFailure();
      }
    }
  }
}
