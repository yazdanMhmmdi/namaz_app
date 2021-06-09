import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:namaz_app/data/model/narratives_model.dart';
import 'package:namaz_app/data/repository/narratives_repository.dart';

part 'narratives_event.dart';
part 'narratives_state.dart';

class NarrativesBloc extends Bloc<NarrativesEvent, NarrativesState> {
  NarrativesBloc() : super(NarrativesInitial());
  NarrativesRepository _repository = new NarrativesRepository();
  NarrativesModel _model;
  int page = 1;
  int totalPage;
  @override
  Stream<NarrativesState> mapEventToState(
    NarrativesEvent event,
  ) async* {
    if (event is GetNarrativesList) {
      try {
        if (page == 1) {
          yield NarrativesLoading();

          _model = await _repository.getShohadaItems(page.toString());
          if (_model.narratives.length == 0) {
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield NarrativesSuccess(narrativesModel: _model);
          }
        } else if (page <= totalPage) {
          yield NarrativesLazyLoading(narrativesModel: _model);
          NarrativesModel _tempModel =
              await _repository.getShohadaItems(page.toString());
          _tempModel.narratives.forEach((element) {
            _model.narratives.add(element);
          });
          page++;
          yield NarrativesSuccess(narrativesModel: _model);
        }
      } catch (err) {
        yield NarrativesFailure();
      }
    }
  }
}
