import 'user.dart';

class Patient extends User {
  int _age;
  String? _description;

  int get age => _age;
  String? get description => _description;

  set description(String? value) => _description = value;
  set age(int newAge) => _age = newAge;

  Patient({
    required String id,
    required String email,
    required String password,
    required Gender gender,
    required String name,
    required int age,
    String? description,
  })  : _age = age,
        _description = description,
        super(
          id: id,
          email: email,
          password: password,
          role: UserRole.patient,
          gender: gender,
          name: name,
        );

  factory Patient.fromMap(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      email: (json['email'] as String?) ?? '',
      password: (json['password'] as String?) ?? '',
      gender: json['gender'] == 'Male' ? Gender.Male : Gender.Female,
      name: (json['name'] as String?) ?? 'Unknown',
      age: (json['age'] != null) ? json['age'] as int : 0,
      description: json['description'] as String?,
    );
}



  @override
  String toString() {
    return '''
      Patient ID: $id
      Name: $name
      Age: $age
      Gender: ${gender.name}
      Email: $email
      Description: $description
    ''';
  }
}
