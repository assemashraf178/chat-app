class MessageModel {
  String? text;
  String? senderUid;
  String? receiverUid;
  String? dateTime;
  String? image;
  String? userImage;

  MessageModel({
    this.text,
    this.dateTime,
    this.receiverUid,
    this.senderUid,
    this.image,
    this.userImage,
  });

  MessageModel.fromJson(Map<String, dynamic>? json) {
    text = json!['text'];
    dateTime = json['dateTime'];
    receiverUid = json['receiverUid'];
    senderUid = json['senderUid'];
    image = json['image'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dateTime': dateTime,
      'receiverUid': receiverUid,
      'senderUid': senderUid,
      'image': image,
      'userImage': userImage,
    };
  }
}
