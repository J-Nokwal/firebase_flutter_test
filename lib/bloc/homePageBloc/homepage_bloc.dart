import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_test/repositories/userRepository.dart';
import 'package:flutter/foundation.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  UserRepository userRepository;
  HomePageBloc({@required UserRepository userRepository})
      : super(LogOutInitialState()) {
    this.userRepository = UserRepository();
  }

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    if (event is LogOutEvent) {
      print("LOG out Bloc");
      userRepository.signOut();
      yield LogOutSuccessState();
    }
  }
}
