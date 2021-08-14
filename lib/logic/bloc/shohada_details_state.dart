part of 'shohada_details_bloc.dart';

abstract class ShohadaDetailsState extends Equatable {
  const ShohadaDetailsState();

  @override
  List<Object> get props => [];
}

class ShohadaDetailsInitial extends ShohadaDetailsState {}

class ShohadaDetailsLoading extends ShohadaDetailsState {}

class ShohadaDetailsSuccess extends ShohadaDetailsState {
  ShohadaDetailsModel shohadaDetailsModel;
  String liked;
  bool featureDiscovery;
  String blurHash;
  ShohadaDetailsSuccess(
      {this.shohadaDetailsModel,
      this.liked,
      this.featureDiscovery,
      this.blurHash});
  @override
  List<Object> get props => [
        this.shohadaDetailsModel,
        this.liked,
        this.featureDiscovery,
        this.blurHash
      ];
}

class ShohadaDetailsFailure extends ShohadaDetailsState {}

class LikeShohadaSuccess extends ShohadaDetailsState {
  ShohadaDetailsModel shohadaDetailsModel;
  String liked;
  LikeShohadaSuccess({this.shohadaDetailsModel, this.liked});
  @override
  List<Object> get props => [this.shohadaDetailsModel, this.liked];
}
