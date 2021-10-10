part of 'showcase_bloc.dart';

abstract class ShowcaseState extends Equatable {
  const ShowcaseState();

  @override
  List<Object> get props => [];
}

class ShowcaseInitial extends ShowcaseState {}

class ShowcaseResult extends ShowcaseState {
  bool isShowcase = false;
  ShowcaseResult({@required this.isShowcase});
  @override
  List<Object> get props => [this.isShowcase];
}
