part of 'shohada_details_bloc.dart';

abstract class ShohadaDetailsEvent extends Equatable {
  const ShohadaDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetShohadaDetails extends ShohadaDetailsEvent {
  String shohada_id;
  GetShohadaDetails({@required this.shohada_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.shohada_id];
}

class LikeShohada extends ShohadaDetailsEvent {
  String user_id, shohada_id;
  LikeShohada({this.shohada_id, this.user_id});
  @override
  List<Object> get props => [this.shohada_id, user_id];
}

class DisLikeShohada extends ShohadaDetailsEvent {
  String user_id, shohada_id;
  DisLikeShohada({this.shohada_id, this.user_id});
  @override
  List<Object> get props => [this.shohada_id, user_id];
}
