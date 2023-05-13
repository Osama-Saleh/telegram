
// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? image;
  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'image': image,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      dateTime: map['dateTime'],
      text: map['text'],
      image: map['image'],
    );
  }
}
