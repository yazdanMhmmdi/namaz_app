part of 'narratives_bloc.dart';

abstract class NarrativesState extends Equatable {
  const NarrativesState();

  @override
  List<Object> get props => [];
}

class NarrativesInitial extends NarrativesState {}

class NarrativesLoading extends NarrativesState {}

class NarrativesSuccess extends NarrativesState {
  NarrativesModel narrativesModel;
  NarrativesSuccess({this.narrativesModel});
  @override
  // TODO: implement props
  List<Object> get props => [this.narrativesModel];
}

class NarrativesLazyLoading extends NarrativesState {
  NarrativesModel narrativesModel;
  NarrativesLazyLoading({this.narrativesModel});
  @override
  List<Object> get props => [this.narrativesModel];
}

class NarrativesListCompleted extends NarrativesState {
  NarrativesModel narrativesModel;
  NarrativesListCompleted({this.narrativesModel});
  @override
  List<Object> get props => [this.narrativesModel];
}

class NarrativesSearchEmpty extends NarrativesState {
  NarrativesModel narrativesModel;
  NarrativesSearchEmpty({this.narrativesModel});
  @override
  List<Object> get props => [this.narrativesModel];
}

class NarrativesSearchLoading extends NarrativesState {}

class NarrativesFailure extends NarrativesState {}
