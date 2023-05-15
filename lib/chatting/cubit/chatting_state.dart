part of 'chatting_cubit.dart';


abstract class ChattingState {}

class ChattingInitial extends ChattingState {}

class PressEmojiState extends ChattingState {}
class ChangekeyboardTypeState extends ChattingState {}

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

class RecordMessageSuccessState extends ChattingState {}

class TimeRecordChangeState extends ChattingState {}

class PlayRecordState extends ChattingState {}

class UploadRecordLoadingState extends ChattingState {}

class UploadRecordSuccessState extends ChattingState {}

class UploadRecordErrorState extends ChattingState {}