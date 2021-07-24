part of 'ahkam_bloc.dart';

abstract class AhkamEvent extends Equatable {
  const AhkamEvent();

  @override
  List<Object> get props => [];
}

class GetAhkamItems extends AhkamEvent {
  String marjae_id, search;
  GetAhkamItems({@required this.marjae_id, @required this.search});

  @override
  List<Object> get props => [this.marjae_id, this.search];
}

class SearchAhkamItems extends AhkamEvent {
  String marjae_id, search;
  SearchAhkamItems({@required this.marjae_id, @required this.search});
  @override
  List<Object> get props => [this.marjae_id, this.search];
}
