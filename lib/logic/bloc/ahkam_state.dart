part of 'ahkam_bloc.dart';

abstract class AhkamState extends Equatable {
  const AhkamState();

  @override
  List<Object> get props => [];
}

class AhkamInitial extends AhkamState {}

class AhkamLoading extends AhkamState {}

class AhkamLazyLoading extends AhkamState {
  AhkamModel ahkamModel;
  AhkamLazyLoading({this.ahkamModel});
  @override
  List<Object> get props => [this.ahkamModel];
}

class AhkamSuccess extends AhkamState {
  AhkamModel ahkamModel;
  AhkamSuccess({this.ahkamModel});
  @override
  List<Object> get props => [this.ahkamModel];
}

class AhkamListCompleted extends AhkamState {
  AhkamModel ahkamModel;
  AhkamListCompleted({this.ahkamModel});
  @override
  List<Object> get props => [this.ahkamModel];
}

class AhkamSearchEmpty extends AhkamState {
  AhkamModel ahkamModel;
  AhkamSearchEmpty({this.ahkamModel});
  @override
  List<Object> get props => [this.ahkamModel];
}

class AhkamSearchLoading extends AhkamState {}

class AhkamFailure extends AhkamState {}
