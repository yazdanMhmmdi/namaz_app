part of 'video_details_bloc.dart';

abstract class VideoDetailsEvent extends Equatable {
  const VideoDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetVideoDetails extends VideoDetailsEvent {
  String video_id;
  GetVideoDetails({@required this.video_id});
}

class LikeVideo extends VideoDetailsEvent {
  String video_id, user_id;
  LikeVideo({@required this.video_id, @required this.user_id});
  @override
  List<Object> get props => [this.video_id, this.user_id];
}

class DisLikeVideo extends VideoDetailsEvent {
  String video_id, user_id;
  DisLikeVideo({@required this.video_id, @required this.user_id});
  @override
  List<Object> get props => [this.user_id, this.video_id];
}
