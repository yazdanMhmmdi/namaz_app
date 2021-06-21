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

class GetVideosFavorite extends FavoriteEvent {}

class GetAhkamFavorite extends FavoriteEvent {}

class GetNarrativesFavorite extends FavoriteEvent {}

class GetShohadaFavorite extends FavoriteEvent {}
