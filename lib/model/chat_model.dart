class ChatModel {
  // List<String>? msg;
  // // String? msg;
  // ChatModel({this.msg});
  // Map<String, dynamic> tomsg() {
  //   return {
  //     // "msg": msg ?? ""
  //     "msg": msg != null && msg!.isNotEmpty ? msg!.map((e) => e.toString()) : []
  //   };
  // }

  String? message, sender, timestamp, msgId;
  ChatModel({this.message, this.sender, this.timestamp, this.msgId});
  Map<String, dynamic> tomsg() {
    return {
      "message": message ?? "",
      "sender": "ankit",
      "timestamp": DateTime.now().toIso8601String()
    };
  }

  ChatModel.fromchat(Map json, this.msgId)
      : message = json['message'],
        sender = json['sender'],
        timestamp = json['timestamp'];
}
