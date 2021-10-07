part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class SetThemeStatus extends ThemeEvent {
  bool darkModeStatus;
  double fontSize;
  SetThemeStatus({@required this.darkModeStatus, @required this.fontSize});

  @override
  List<Object> get props => [this.darkModeStatus];
}

class GetThemeStatusFromLocalStorage extends ThemeEvent {}

class GetThemeStatus extends ThemeEvent {}
