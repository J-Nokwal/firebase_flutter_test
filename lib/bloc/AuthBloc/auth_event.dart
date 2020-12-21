part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AppStartedEvent extends AuthEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
