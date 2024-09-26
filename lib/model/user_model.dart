class Usermodel {
  String? docId, uid, name, email;

  Usermodel({this.docId, this.name, this.email, this.uid});
  Map<String, dynamic> tomap(String uid) {
    return {"uid": uid, "name": name, "email": email};
  }

  Usermodel copyWith({String? id, String? name, String? email}) {
    return Usermodel(
        docId: id ?? this.docId,
        name: name ?? this.name,
        email: email ?? this.email);
  }

  // Usermodel.fromjson(Map<String, dynamic> json, this.docId)
  //     : name = json["name"] ?? "",
  //       email = json["email"] ?? "",
  //       uid = json["uid"] ?? "";
}
