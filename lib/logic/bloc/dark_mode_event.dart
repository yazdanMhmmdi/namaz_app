part of 'dark_mode_bloc.dart';

abstract class DarkModeEvent extends Equatable {
  const DarkModeEvent();

  @override
  List<Object> get props => [];
}

class DarkModeStatus extends DarkModeEvent {
  bool darkModeStatus;
  DarkModeStatus({@required this.darkModeStatus});

  @override
  List<Object> get props => [this.darkModeStatus];
}
