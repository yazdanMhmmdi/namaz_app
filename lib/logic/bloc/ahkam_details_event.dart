part of 'ahkam_details_bloc.dart';

abstract class AhkamDetailsEvent extends Equatable {
  const AhkamDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetAhkamDetails extends AhkamDetailsEvent {
  String ahkam_id, user_id;
  GetAhkamDetails({@required this.ahkam_id, @required this.user_id});

  @override
  // TODO: implement props
  List<Object> get props => [this.ahkam_id];
}

class LikeAhkam extends AhkamDetailsEvent {
  String user_id, ahkam_id;
  LikeAhkam({@required this.user_id, @required this.ahkam_id});
  @override
  List<Object> get props => [this.ahkam_id, this.user_id];
}

class DisLikeAhkam extends AhkamDetailsEvent {
  String user_id, ahkam_id;
  DisLikeAhkam({@required this.user_id, @required this.ahkam_id});
  @override
  List<Object> get props => [this.ahkam_id, this.user_id];
}
