part of 'dark_mode_bloc.dart';

abstract class DarkModeEvent extends Equatable {
  const DarkModeEvent();

  @override
  List<Object> get props => [];
}

class SetDarkModeStatus extends DarkModeEvent {
  bool darkModeStatus;
  SetDarkModeStatus({@required this.darkModeStatus});

  @override
  List<Object> get props => [this.darkModeStatus];
}

class GetDarkModestatusFromLocalStorage extends DarkModeEvent {}

class GetDarkModeStatus extends DarkModeEvent {}
