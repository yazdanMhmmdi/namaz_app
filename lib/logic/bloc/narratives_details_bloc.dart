import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:namaz_app/data/model/narratives_details_screen.dart';
import 'package:namaz_app/data/repository/narratives_details_repository.dart';

part 'narratives_details_event.dart';
part 'narratives_details_state.dart';

class NarrativesDetailsBloc
    extends Bloc<NarrativesDetailsEvent, NarrativesDetailsState> {
  NarrativesDetailsBloc() : super(NarrativesDetailsInitial());

  NarrativesDetailsRepository _repository = new NarrativesDetailsRepository();
  NarrativesDetailsModel _model;
  @override
  Stream<NarrativesDetailsState> mapEventToState(
    NarrativesDetailsEvent event,
  ) async* {
    if (event is GetNarrativesDetails) {
      try {
        yield NarrativesDetailsLoading();
        _model = await _repository.getNarrativesDetails(event.narratives_id);
        if (_model.error == "0") {
          yield NarrativesDetailsSuccess(narrativesDetailsModel: _model);
        } else {
          yield NarrativesDetailsFailure();
        }
      } catch (err) {
        yield NarrativesDetailsFailure();
      }
    }
  }
}
