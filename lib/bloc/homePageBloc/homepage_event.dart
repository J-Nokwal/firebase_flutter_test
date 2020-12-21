part of 'homepage_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class LogOutEvent extends HomePageEvent {}
