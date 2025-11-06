import 'package:my_first_project/domain/appointment.dart';
import 'user.dart';

class Patient extends User {
  String? _description;

  String? get description => _description;
  set description(String? value) => _description = value;

  Patient({
    required String id,
    required String email,
    required String password,
    required Gender gender,
    required String name,
    required int age,
    String? description,
    List<Appointment>? appointments,
  })  :  _description = description,
        super(
          id: id,
          email: email,
          age: age,
          password: password,
          role: UserRole.patient,
          gender: gender,
          name: name,
          appointments: appointments,
        );

  // Factory constructor for create patient obj
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
}
