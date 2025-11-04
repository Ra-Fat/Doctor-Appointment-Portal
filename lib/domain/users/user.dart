enum UserRole{
  patient,
  doctor
}
enum Gender { Male, Female }

class User{
  final String id;
  final String email;
  final String password;
  final UserRole role;
  final Gender gender;

  User({
    required this.id, 
    required this.email, 
    required this.password, 
    required this.role,
    required this.gender,
  });


  factory User.fromJson(Map<String,dynamic> json){
    return User(
        id: json['id'] as String,
        email: json['email'] as String,
        password: json['passwordHash'] as String,
        role: UserRole.values.firstWhere(
          (r) => r.toString().split('.').last == json['role'],
          orElse: () => UserRole.patient,
        ),
        gender: json['gender'] == 'Male' ? Gender.Male : Gender.Female,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'passwordHash': password,
      'role': role.toString().split('.').last,
      'gender': gender.toString().split('.').last,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, role: ${role.toString().split('.').last}, gender: ${gender.toString().split('.').last})';
  }
}