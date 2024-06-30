class User {
  bool online;
  String email;
  String name;
  String uid;

  User({
    required this.email,
    required this.online,
    required this.name,
    required this.uid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["nombre"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": name,
        "email": email,
        "online": online,
        "uid": uid,
      };
}
