part of 'narratives_details_bloc.dart';

abstract class NarrativesDetailsState extends Equatable {
  const NarrativesDetailsState();

  @override
  List<Object> get props => [];
}

class NarrativesDetailsInitial extends NarrativesDetailsState {}

class NarrativesDetailsLoading extends NarrativesDetailsState {}

class NarrativesDetailsSuccess extends NarrativesDetailsState {
  NarrativesDetailsModel narrativesDetailsModel;
  NarrativesDetailsSuccess({this.narrativesDetailsModel});
  @override
  // TODO: implement props
  List<Object> get props => [this.narrativesDetailsModel];
}

class NarrativesDetailsFailure extends NarrativesDetailsState {}
