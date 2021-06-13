part of 'ahkam_bloc.dart';

abstract class AhkamEvent extends Equatable {
  const AhkamEvent();

  @override
  List<Object> get props => [];
}

class GetAhkamItems extends AhkamEvent {
  String marjae_id;
  GetAhkamItems({@required this.marjae_id});

  @override
  // TODO: implement props
  List<Object> get props => [this.marjae_id];
}
