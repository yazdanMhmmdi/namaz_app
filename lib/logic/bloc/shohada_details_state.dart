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
  ShohadaDetailsSuccess({this.shohadaDetailsModel});
  @override
  List<Object> get props => [this.shohadaDetailsModel];
}

class ShohadaDetailsFailure extends ShohadaDetailsState {}
