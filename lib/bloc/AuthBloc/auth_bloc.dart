import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/repositories/userRepository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;

  AuthBloc({@required UserRepository userRepository})
      : super(AuthInitialState()) {
    this.userRepository = UserRepository();
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    try {
      if (event is AppStartedEvent) {
        var isSignedIn = await userRepository.isSignedIn();
        if (isSignedIn) {
          yield AuthenticatedState(user: await userRepository.getCurrentUser());
        } else {
          yield UnAuthenticatedState();
        }
      }
    } on Exception {
      yield UnAuthenticatedState();
    }
  }
}
