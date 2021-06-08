part of 'marjae_bloc.dart';

abstract class MarjaeState extends Equatable {
  const MarjaeState();

  @override
  List<Object> get props => [];
}

class MarjaeInitial extends MarjaeState {}

class MarjaeLoading extends MarjaeState {}

class MarjaeSuccess extends MarjaeState {
  MarjaeModel marjaeModel;
  MarjaeSuccess({this.marjaeModel});
  @override
  // TODO: implement props
  List<Object> get props => [this.marjaeModel];
}

class MarjaeFailure extends MarjaeState {}
