part of 'userLogIn_bloc.dart';

abstract class UserLogInState extends Equatable {
  const UserLogInState();

  @override
  List<Object> get props => [];
}

class UserLogInInitialState extends UserLogInState {}

class UserLogInLoadingState extends UserLogInState {}

class UserLogInSuccessfullState extends UserLogInState {
  final User user;
  UserLogInSuccessfullState({@required this.user});
}

class UserLogInFailureState extends UserLogInState {
  final String message;
  UserLogInFailureState({@required this.message});
}
