part of 'userLogIn_bloc.dart';

abstract class UserLogInEvent extends Equatable {
  const UserLogInEvent();

  @override
  List<Object> get props => [];
}

class LogInButtonPressedEvent extends UserLogInEvent {
  final String email, password;
  LogInButtonPressedEvent({
    @required this.email,
    @required this.password,
  });
}
