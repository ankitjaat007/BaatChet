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

  String? message, sender, timestamp;
  ChatModel({this.message, this.sender, this.timestamp});
  Map<String, dynamic> tomsg() {
    return {
      "message": message ?? "",
      "sender": "ankit",
      "timestamp": DateTime.now()
    };
  }
}
