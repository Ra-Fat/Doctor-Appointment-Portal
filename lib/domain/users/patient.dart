import 'user.dart';

class Patient extends User {
  String _name;
  int _age;
  String? _description;

  String get name => _name;
  int get age => _age;
  String? get description => _description;

  set description(String? value) => _description = value;
  set name(String newName) => _name = newName;
  set age(int newAge) => _age = newAge;

  Patient({
    required String id,
    required String email,
    required String password,
    required Gender gender,
    required String name,
    required int age,
    String? description,
  })  : _name = name,
        _age = age,
        _description = description,
        super(id: id, email: email, password: password, role: UserRole.patient, gender: gender);


  factory Patient.fromMap(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      gender: json['gender'] == 'Male' ? Gender.Male : Gender.Female,
      name: json['name'] as String,
      age: json['age'] as int,
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
