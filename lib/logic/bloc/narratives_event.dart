part of 'narratives_bloc.dart';

abstract class NarrativesEvent extends Equatable {
  const NarrativesEvent();

  @override
  List<Object> get props => [];
}

class GetNarrativesList extends NarrativesEvent {
  String search;
  GetNarrativesList({@required this.search});
  @override
  List<Object> get props => [this.search];
}

class SearchNarrativesItems extends NarrativesEvent {
  String search;
  SearchNarrativesItems({@required this.search});
  @override
  List<Object> get props => [this.search];
}
