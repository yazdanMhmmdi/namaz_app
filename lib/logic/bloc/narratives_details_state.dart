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
  String liked;
  bool featureDiscovery;
  NarrativesDetailsSuccess(
      {this.narrativesDetailsModel, this.liked, this.featureDiscovery});
  @override
  // TODO: implement props
  List<Object> get props =>
      [this.narrativesDetailsModel, this.liked, this.featureDiscovery];
}

class NarrativesDetailsFailure extends NarrativesDetailsState {}

class LikeNarrativesSuccess extends NarrativesDetailsState {
  NarrativesDetailsModel narrativesDetailsModel;
  String liked;
  LikeNarrativesSuccess(
      {@required this.narrativesDetailsModel, @required this.liked});

  @override
  List<Object> get props => [this.narrativesDetailsModel, this.liked];
}
