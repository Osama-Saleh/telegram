part of 'chatting_cubit.dart';


abstract class ChattingState {}

class ChattingInitial extends ChattingState {}

class SendMessageLoadingState extends ChattingState {}

class SendMessageSuccessState extends ChattingState {}

class SendMessageErrorState extends ChattingState {}

class GetMessageSuccessState extends ChattingState {}

class SelectImageLoadingState extends ChattingState {}

class SelectImageSuccessState extends ChattingState {}

class SelectImageErrorState extends ChattingState {}

class UploadImageLoadingState extends ChattingState {}

class UploadImageSuccessState extends ChattingState {}

class UploadImageErrorState extends ChattingState {}