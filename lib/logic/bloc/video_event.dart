part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class GetVideoItems extends VideoEvent {
  String search;
  GetVideoItems({@required this.search});
  @override
  List<Object> get props => [this.search];
}

class SearchVideoItems extends VideoEvent {
  String search;
  SearchVideoItems({@required this.search});
  @override
  List<Object> get props => [this.search];
}
