part of 'dark_mode_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SetDarkModeStatus extends ThemeEvent {
  bool darkModeStatus;
  SetDarkModeStatus({@required this.darkModeStatus});

  @override
  List<Object> get props => [this.darkModeStatus];
}

class GetDarkModestatusFromLocalStorage extends ThemeEvent {}

class GetDarkModeStatus extends ThemeEvent {}
