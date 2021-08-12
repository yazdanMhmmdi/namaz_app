part of 'shohada_bloc.dart';

abstract class ShohadaState extends Equatable {
  const ShohadaState();

  @override
  List<Object> get props => [];
}

class ShohadaInitial extends ShohadaState {}

class ShohadaLoading extends ShohadaState {}

class ShohadaLazyLoading extends ShohadaState {
  ShohadaModel shohadaModel;
  ShohadaLazyLoading({this.shohadaModel});
}

class ShohadaSuccess extends ShohadaState {
  ShohadaModel shohadaModel;

  ShohadaSuccess({this.shohadaModel});
  @override
  List<Object> get props => [this.shohadaModel];
}

class ShohadaListCompleted extends ShohadaState {
  ShohadaModel shohadaModel;
  ShohadaListCompleted({this.shohadaModel});
  @override
  List<Object> get props => [this.shohadaModel];
}

class ShohadaSearchEmpty extends ShohadaState {
  ShohadaModel shohadaModel;
  ShohadaSearchEmpty({this.shohadaModel});
  @override
  List<Object> get props => [this.shohadaModel];
}

class ShohadaSearchLoading extends ShohadaState {

}

class ShohadaFailure extends ShohadaState {}
