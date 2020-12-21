part of 'userreg_bloc.dart';

abstract class UserRegState extends Equatable {
  const UserRegState();

  @override
  List<Object> get props => [];
}

class UserRegInitialState extends UserRegState {}

class UserLoadingState extends UserRegState {}

class UserRegSuccessfullState extends UserRegState {
  final User user;

  UserRegSuccessfullState({@required this.user});
}

class UserRegFailure extends UserRegState {
  final String message;
  UserRegFailure({@required this.message});
}
