part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLazyLoading extends VideoState {
  VideoModel videoModel;
  VideoLazyLoading({this.videoModel});
  @override
  List<Object> get props => [this.videoModel];
}

class VideoListCompleted extends VideoState {
  VideoModel videoModel;
  VideoListCompleted({this.videoModel});
  @override
  List<Object> get props => [this.videoModel];
}

class VideoSuccess extends VideoState {
  VideoModel videoModel;
  VideoSuccess({this.videoModel});
  @override
  List<Object> get props => [this.videoModel];
}

class VideoFailure extends VideoState {}
