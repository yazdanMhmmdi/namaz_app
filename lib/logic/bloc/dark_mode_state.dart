part of 'dark_mode_bloc.dart';

abstract class DarkModeState extends Equatable {
  const DarkModeState();

  @override
  List<Object> get props => [];
}

class DarkModeInitial extends DarkModeState {
  bool isDark = false;
  DarkModeInitial({@required this.isDark});
  @override
  List<Object> get props => [this.isDark];
}

class DarkModeEnable extends DarkModeState {
  bool isDark = false;
  DarkModeEnable({@required this.isDark});
  @override
  List<Object> get props => [this.isDark];
}

class DarkModeDisable extends DarkModeState {
  bool isDark = false;
  DarkModeDisable({@required this.isDark});
  @override
  List<Object> get props => [this.isDark];
}
