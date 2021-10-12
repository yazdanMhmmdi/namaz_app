part of 'live_tv_details_bloc.dart';

abstract class LiveTvDetailsState extends Equatable {
  const LiveTvDetailsState();

  @override
  List<Object> get props => [];
}

class LiveTvDetailsInitial extends LiveTvDetailsState {}

class LiveTvDetailsLoading extends LiveTvDetailsState {}

class LiveTvDetailsSuccess extends LiveTvDetailsState {
  LiveTvDetailModel liveTvDetailModel;
  ChewieController chewieController;

  LiveTvDetailsSuccess(
      {@required this.liveTvDetailModel, @required this.chewieController});
  @override
  List<Object> get props => [this.liveTvDetailModel];
}

class LiveTvDetailsFailure extends LiveTvDetailsState {}
