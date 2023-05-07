// ignore_for_file: public_member_api_docs, sort_constructors_first
class HomeStates {}

class HomeInitState extends HomeStates {}

class ChangeNameState extends HomeStates {}

class ShowPasswordState extends HomeStates {}

class RegisterSuccessState extends HomeStates {}

class RegisterErrorState extends HomeStates {}

class LoginSuccessState extends HomeStates {
  final String? token;

  LoginSuccessState(this.token);
}

class LoginErrorState extends HomeStates {}

class SaveUserDataLoadingState extends HomeStates {}

class SaveUserDataSuccessState extends HomeStates {}

class SaveUserDataErrorState extends HomeStates {}

class GetAllUserLoadingState extends HomeStates {}

class GetAllUserSuccessState extends HomeStates {}

class GetAllUserErrorState extends HomeStates {}

class SendMessageLoadingState extends HomeStates {}

class SendMessageSuccessState extends HomeStates {}

class SendMessageErrorState extends HomeStates {}

class GetMessageSuccessState extends HomeStates {}
