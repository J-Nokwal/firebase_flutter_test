part of 'userreg_bloc.dart';

abstract class UserRegEvent extends Equatable {
  const UserRegEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressedEvent extends UserRegEvent {
  final String email, password;
  SignUpButtonPressedEvent({
    @required this.email,
    @required this.password,
  });
}
