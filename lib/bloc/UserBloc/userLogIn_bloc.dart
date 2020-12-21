import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/repositories/userRepository.dart';
import 'package:flutter/foundation.dart';

part 'userLogIn_event.dart';
part 'userLogIn_state.dart';

class UserLogInBloc extends Bloc<UserLogInEvent, UserLogInState> {
  UserRepository userRepository;
  UserLogInBloc({@required UserRepository userRepository})
      : super(UserLogInInitialState()) {
    this.userRepository = UserRepository();
  }

  @override
  Stream<UserLogInState> mapEventToState(
    UserLogInEvent event,
  ) async* {
    try {
      if (event is LogInButtonPressedEvent) {
        yield UserLogInLoadingState();
        var user = await userRepository.signInEmailAndPassword(
            event.email, event.password);
        yield UserLogInSuccessfullState(user: user);
      }
    } on Exception catch (e) {
      yield UserLogInFailureState(message: e.toString());
    }
  }
}
