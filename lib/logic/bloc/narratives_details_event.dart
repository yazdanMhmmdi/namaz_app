part of 'narratives_details_bloc.dart';

abstract class NarrativesDetailsEvent extends Equatable {
  const NarrativesDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetNarrativesDetails extends NarrativesDetailsEvent {
  String narratives_id;
  GetNarrativesDetails({this.narratives_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.narratives_id];
}

class LikeNarratives extends NarrativesDetailsEvent {
  String user_id, narratives_id;
  LikeNarratives({@required this.user_id, @required this.narratives_id});
  @override
  List<Object> get props => [this.narratives_id, this.user_id];
}

class DisLikeNarratives extends NarrativesDetailsEvent {
  String user_id, narratives_id;
  DisLikeNarratives({@required this.user_id, @required this.narratives_id});
  @override
  List<Object> get props => [this.narratives_id, this.user_id];
}
