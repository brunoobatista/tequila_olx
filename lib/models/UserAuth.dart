import 'dart:convert';

class UserAuth {
  String email;
  String password;

  UserAuth(
    this.email,
    this.password,
  );

  UserAuth copyWith({
    String? email,
    String? password,
  }) {
    return UserAuth(
      email ?? this.email,
      password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory UserAuth.fromMap(Map<String, dynamic> map) {
    return UserAuth(
      map['email'],
      map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuth.fromJson(String source) =>
      UserAuth.fromMap(json.decode(source));

  @override
  String toString() => 'UserAuth(email: $email, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAuth &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
