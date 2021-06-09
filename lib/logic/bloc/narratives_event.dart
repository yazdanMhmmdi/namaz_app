part of 'narratives_bloc.dart';

abstract class NarrativesEvent extends Equatable {
  const NarrativesEvent();

  @override
  List<Object> get props => [];
}

class GetNarrativesList extends NarrativesEvent {
  
}
