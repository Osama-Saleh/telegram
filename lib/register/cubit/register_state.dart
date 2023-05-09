part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ShowPasswordState extends RegisterState {}


class RegisterSuccessState extends RegisterState {}

class RegisterErrorState extends RegisterState {}

class SaveUserDataLoadingState extends RegisterState {}

class SaveUserDataSuccessState extends RegisterState {}

class SaveUserDataErrorState extends RegisterState {}
