part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  bool isDark = false;
  double fontSize = 0;
  ThemeInitial({@required this.isDark, @required this.fontSize});
  @override
  List<Object> get props => [this.isDark, this.fontSize];
}

class DarkModeEnable extends ThemeState {
  bool isDark = false;
  double fontSize = 0;
  DarkModeEnable({@required this.isDark, @required this.fontSize});
  @override
  List<Object> get props => [this.isDark, this.fontSize];
}

class DarkModeDisable extends ThemeState {
  bool isDark = false;
  double fontSize = 0;
  DarkModeDisable({@required this.isDark, @required this.fontSize});
  @override
  List<Object> get props => [this.isDark, this.fontSize];
}
