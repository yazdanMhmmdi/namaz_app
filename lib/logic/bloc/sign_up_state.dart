part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  String user_id;
  SignUpSuccess({@required this.user_id});
  @override
  List<Object> get props => [this.user_id];
}

class SignUpFailure extends SignUpState {}
