import 'message_model.dart';

class UserModel {
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? uId;
  String? image;
  bool? isVerificated;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.bio,
    this.image,
    this.isVerificated,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    isVerificated = json['isVerificated'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'bio': bio,
      'phone': phone,
      'uId': uId,
      'image': image,
      'isVerificated': isVerificated,
    };
  }
}

class Chats {
  List<MessageModel> messages = [];
}
