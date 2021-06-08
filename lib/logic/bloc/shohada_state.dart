part of 'shohada_bloc.dart';

abstract class ShohadaState extends Equatable {
  const ShohadaState();

  @override
  List<Object> get props => [];
}

class ShohadaInitial extends ShohadaState {}

class ShohadaLoading extends ShohadaState {}

class ShohadaSuccess extends ShohadaState {
  ShohadaModel shohadaModel;

  ShohadaSuccess({this.shohadaModel});
}

class ShohadaFailure extends ShohadaState {}
