part of 'shohada_bloc.dart';

abstract class ShohadaEvent extends Equatable {
  const ShohadaEvent();

  @override
  List<Object> get props => [];
}

class GetShohadaList extends ShohadaEvent {
  
}
