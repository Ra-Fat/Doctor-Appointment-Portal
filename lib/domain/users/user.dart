enum UserRole {
  patient,
  doctor
}

enum Gender { Male, Female }

class User {
  final String id;
  final String email;
  final String password;
  final UserRole role;
  final Gender gender;
  final String name;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: UserRole.values.firstWhere(
        (r) => r.toString().split('.').last == json['role'],
        orElse: () => UserRole.patient,
      ),
      gender: json['gender'] == 'Male' ? Gender.Male : Gender.Female,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'role': role.toString().split('.').last,
      'gender': gender.toString().split('.').last,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: ${role.toString().split('.').last}, gender: ${gender.toString().split('.').last})';
  }
}
