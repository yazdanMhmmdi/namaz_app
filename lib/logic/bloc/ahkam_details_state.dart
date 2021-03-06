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
  String liked;
  AhkamDetailsSuccess({
    @required this.ahkamDetailsModel,
    @required this.liked,
  });

  @override
  List<Object> get props => [this.ahkamDetailsModel, this.liked];
}

class AhkamDetailsFailure extends AhkamDetailsState {}

class LikeAhkamSuccess extends AhkamDetailsState {
  AhkamDetailsModel ahkamDetailsModel;
  String liked;
  LikeAhkamSuccess({@required this.ahkamDetailsModel, @required this.liked});

  @override
  // TODO: implement props
  List<Object> get props => [this.ahkamDetailsModel, this.liked];
}
