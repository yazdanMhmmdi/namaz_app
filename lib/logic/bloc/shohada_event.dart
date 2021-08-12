part of 'shohada_bloc.dart';

abstract class ShohadaEvent extends Equatable {
  const ShohadaEvent();

  @override
  List<Object> get props => [];
}

class GetShohadaList extends ShohadaEvent {
  String search;
  GetShohadaList({@required this.search});
  @override
  List<Object> get props => [this.search];
}

class SearchShohadaItems extends ShohadaEvent {
  String search;
  SearchShohadaItems({@required this.search});
  @override
  List<Object> get props => [this.search];
}
