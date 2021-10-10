part of 'showcase_bloc.dart';

abstract class ShowcaseEvent extends Equatable {
  const ShowcaseEvent();

  @override
  List<Object> get props => [];
}

class ShowcaseSettings extends ShowcaseEvent {
  List<GlobalKey<State<StatefulWidget>>> keys;
  BuildContext buildContext;
  ShowcaseSettings({@required this.keys, @required this.buildContext});
  @override
  List<Object> get props => [this.keys, this.buildContext];
}

class ShowcaseFavorite extends ShowcaseEvent {
  List<GlobalKey<State<StatefulWidget>>> keys;
  BuildContext buildContext;
  ShowcaseFavorite({@required this.keys, @required this.buildContext});
  @override
  List<Object> get props => [this.keys, this.buildContext];
}

class ShowcaseFavoriteItem extends ShowcaseEvent {
  List<GlobalKey<State<StatefulWidget>>> keys;
  BuildContext buildContext;
  ShowcaseFavoriteItem({@required this.keys, @required this.buildContext});
  @override
  List<Object> get props => [this.keys, this.buildContext];
}
