import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModelFire {
  String? name;
  String? mail;
  String? image;
  String? token;
  UserModelFire({
    this.name,
    this.mail,
    this.image,
    this.token,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'mail': mail,
      'image': image,
      'token': token,
    };
  }

  factory UserModelFire.fromJson(Map<String, dynamic> json) {
    return UserModelFire(
      name: json['name'] != null ? json['name'] as String : null,
      mail: json['mail'] != null ? json['mail'] as String : null,
      image: json['image'] != null ? json['image'] as String : null,
      token: json['token'] != null ? json['token'] as String : null,
    );
  }


}
