part of 'user_cubit.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class GetAllUserLoadingState extends UserState {}

class GetAllUserSuccessState extends UserState {}

class GetAllUserErrorState extends UserState {}
