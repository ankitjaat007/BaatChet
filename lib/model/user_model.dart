class Usermodel {
  String? id, name, email;

  Usermodel({this.id, this.name, this.email});
  Map<String, dynamic> tomap(String uid) {
    return {"uid": uid, "name": name, "email": email};
  }

  Usermodel copyWith({String? id, String? name, String? email}) {
    return Usermodel(
        id: id ?? this.id, name: name ?? this.name, email: email ?? this.email);
  }

  // Usermodel.fromjson(Map<String, dynamic> json, this.id)
  //     : name = json["name"] ?? "",
  //       email = json["email"] ?? "";
}
