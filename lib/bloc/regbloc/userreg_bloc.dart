import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/repositories/userRepository.dart';
import 'package:flutter/foundation.dart';

part 'userreg_event.dart';
part 'userreg_state.dart';

class UserRegBloc extends Bloc<UserRegEvent, UserRegState> {
  UserRepository userRepository;
  UserRegBloc({@required UserRepository userRepository})
      : super(UserRegInitialState()) {
    this.userRepository = UserRepository();
  }

  @override
  Stream<UserRegState> mapEventToState(
    UserRegEvent event,
  ) async* {
    try {
      if (event is SignUpButtonPressedEvent) {
        yield UserLoadingState();
        var user = await userRepository.signUpUserWithEmailPass(
            event.email, event.password);
        yield UserRegSuccessfullState(user: user);
      }
    } on Exception catch (e) {
      yield UserRegFailure(message: e.toString());
    }
  }
}
