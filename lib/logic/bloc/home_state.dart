part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  HomeModel homeModel;
  HomeSuccess({this.homeModel});

  @override
  // TODO: implement props
  List<Object> get props => [this.homeModel];
}

class HomeFailure extends HomeState {}


