part of 'live_tv_details_bloc.dart';

abstract class LiveTvDetailsEvent extends Equatable {
  const LiveTvDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetLiveTvDetails extends LiveTvDetailsEvent {
  String liveTvId;

  GetLiveTvDetails({@required this.liveTvId});

  @override
  List<Object> get props => [this.liveTvId];
}
