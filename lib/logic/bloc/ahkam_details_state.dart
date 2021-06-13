part of 'ahkam_details_bloc.dart';

abstract class AhkamDetailsState extends Equatable {
  const AhkamDetailsState();

  @override
  List<Object> get props => [];
}

class AhkamDetailsInitial extends AhkamDetailsState {}

class AhkamDetailsLoading extends AhkamDetailsState {}

class AhkamDetailsSuccess extends AhkamDetailsState {
  AhkamDetailsModel ahkamDetailsModel;
  AhkamDetailsSuccess({@required this.ahkamDetailsModel});

  @override
  // TODO: implement props
  List<Object> get props => [this.ahkamDetailsModel];
}

class AhkamDetailsFailure extends AhkamDetailsState {}
