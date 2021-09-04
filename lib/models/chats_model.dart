import 'message_model.dart';

class ChatsModel {
  List<MessageModel> messages = [];

  ChatsModel(this.messages);

  ChatsModel.fromJson(Map<String, dynamic> json) {
    json['messages'].forEach((elemnt) {
      this.messages.add(MessageModel.fromJson(elemnt));
    });
  }
}
