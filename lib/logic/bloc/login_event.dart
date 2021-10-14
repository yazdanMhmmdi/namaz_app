part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class TryLogin extends LoginEvent {
  String username, password;
  TryLogin({@required this.password,@required this.username});

  @override
  List<Object> get props => [this.username, this.password];
}
