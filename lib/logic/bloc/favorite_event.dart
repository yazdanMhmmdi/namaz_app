part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteItems extends FavoriteEvent {
  String user_id;
  GetFavoriteItems({@required this.user_id});
  @override
  List<Object> get props => [this.user_id];
}

class GetVideosFavorite extends FavoriteEvent {
  bool isDarkMode = false;
  GetVideosFavorite({@required this.isDarkMode});
  @override
  List<Object> get props => [this.isDarkMode];
}

class GetAhkamFavorite extends FavoriteEvent {
  bool isDarkMode = false;
  GetAhkamFavorite({@required this.isDarkMode});
  @override
  List<Object> get props => [this.isDarkMode];
}

class GetNarrativesFavorite extends FavoriteEvent {
  bool isDarkMode = false;
  GetNarrativesFavorite({@required this.isDarkMode});
  @override
  List<Object> get props => [this.isDarkMode];
}

class GetShohadaFavorite extends FavoriteEvent {
  bool isDarkMode = false;
  GetShohadaFavorite({@required this.isDarkMode});
  @override
  List<Object> get props => [this.isDarkMode];
}

class DeleteVideoItem extends FavoriteEvent {
  String user_id, video_id;
  DeleteVideoItem({@required this.user_id, @required this.video_id});
  @override
  List<Object> get props => [this.video_id, this.user_id];
}

class DeleteAhkamItem extends FavoriteEvent {
  String user_id, ahkam_id;
  DeleteAhkamItem({@required this.user_id, @required this.ahkam_id});
  @override
  List<Object> get props => [this.ahkam_id, this.user_id];
}

class DeleteNarrativesItem extends FavoriteEvent {
  String user_id, narratives_id;
  DeleteNarrativesItem({@required this.user_id, @required this.narratives_id});
  @override
  List<Object> get props => [this.narratives_id, this.user_id];
}

class DeleteShohadaItem extends FavoriteEvent {
  String user_id, shohada_id;
  DeleteShohadaItem({@required this.user_id, @required this.shohada_id});
  @override
  List<Object> get props => [this.shohada_id, this.user_id];
}
