part of 'video_details_bloc.dart';

abstract class VideoDetailsState extends Equatable {
  const VideoDetailsState();

  @override
  List<Object> get props => [];
}

class VideoDetailsInitial extends VideoDetailsState {}

class VideoDetailsLoading extends VideoDetailsState {}

class VideoDetailsSuccess extends VideoDetailsState {
  VideoDetailsModel videoDetailsModel;
  ChewieController chewieController;
  String liked;
  VideoDetailsSuccess(
      {this.videoDetailsModel, this.liked, this.chewieController});

  @override
  List<Object> get props =>
      [this.videoDetailsModel, this.liked, this.chewieController];
}

class LikeSuccess extends VideoDetailsState {
  VideoDetailsModel videoDetailsModel;
  ChewieController chewieController;

  String liked;
  LikeSuccess({this.videoDetailsModel, this.liked, this.chewieController});

  @override
  List<Object> get props => [this.videoDetailsModel, this.chewieController,this.liked];
}

class VideoDetailsFailure extends VideoDetailsState {}
