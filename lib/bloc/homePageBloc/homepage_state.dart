part of 'homepage_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class LogOutInitialState extends HomePageState {}

class LogOutSuccessState extends HomePageState {}
