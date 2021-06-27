part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUp extends SignUpEvent {
  String username, password;

  SignUp({@required this.username, @required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}
