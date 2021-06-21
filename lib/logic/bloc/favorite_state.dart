part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteSuccess extends FavoriteState {
  FavoriteModel favoriteModel;
  var tab;
  FavoriteSuccess({this.favoriteModel, this.tab});
  @override
  List<Object> get props => [this.favoriteModel];
}

class FavoriteIsEmpty extends FavoriteState {}

class FavoriteFailure extends FavoriteState {}
