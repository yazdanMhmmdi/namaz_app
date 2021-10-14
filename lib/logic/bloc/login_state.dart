part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  String userId;
  LoginSuccess({@required this.userId});

  @override
  List<Object> get props => [this.userId];
}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {}
