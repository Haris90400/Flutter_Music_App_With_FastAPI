import 'dart:convert';

class UserModel {
  final String email;
  final String name;
  final String id;
  final String token;
  UserModel({
    required this.email,
    required this.name,
    required this.id,
    required this.token,
  });

  UserModel copyWith({
    String? email,
    String? name,
    String? id,
    String? token,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'id': id,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(email: $email, name: $name, id: $id, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.name == name &&
        other.id == id &&
        other.token == token;
  }

  @override
  int get hashCode {
    return email.hashCode ^ name.hashCode ^ id.hashCode ^ token.hashCode;
  }
}
