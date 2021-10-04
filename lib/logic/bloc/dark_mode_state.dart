part of 'dark_mode_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  bool isDark = false;
  ThemeInitial({@required this.isDark});
  @override
  List<Object> get props => [this.isDark];
}

class DarkModeEnable extends ThemeState {
  bool isDark = false;
  DarkModeEnable({@required this.isDark});
  @override
  List<Object> get props => [this.isDark];
}

class DarkModeDisable extends ThemeState {
  bool isDark = false;
  DarkModeDisable({@required this.isDark});
  @override
  List<Object> get props => [this.isDark];
}
