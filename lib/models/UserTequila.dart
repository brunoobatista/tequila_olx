import 'dart:convert';

class UserTequila {
  String? id;
  String? email;
  String? password;
  String? name;
  bool _logged = false;

  UserTequila({
    this.id,
    required this.email,
    required this.password,
    required this.name,
  }) {
    this._logged = false;
  }

  UserTequila.logOn({required this.id, required this.email}) {
    this._logged = true;
  }
  UserTequila.logOff() {
    this._logged = false;
  }

  bool get isLogged => this._logged;

  bool get hasId => this.id != null;

  UserTequila copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
  }) {
    return UserTequila(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory UserTequila.fromMap(Map<String, dynamic> map) {
    return UserTequila(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTequila.fromJson(String source) =>
      UserTequila.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserTequila(id: $id, email: $email, password: $password, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserTequila &&
        other.id == id &&
        other.email == email &&
        other.password == password &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ password.hashCode ^ name.hashCode;
  }
}
