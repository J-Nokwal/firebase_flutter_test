part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthenticatedState extends AuthState {
  final User user;

  AuthenticatedState({@required this.user});
  @override
  List<Object> get props => throw UnimplementedError();
}

class UnAuthenticatedState extends AuthState {
  @override
  List<Object> get props => throw UnimplementedError();
}
