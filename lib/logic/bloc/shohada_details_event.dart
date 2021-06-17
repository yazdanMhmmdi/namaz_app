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
