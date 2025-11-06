import 'package:my_first_project/domain/appointment.dart';

enum UserRole { patient, doctor }

enum Gender { Male, Female }

class User {
  final String id;
  final String email;
  final String password;
  final UserRole role;
  final Gender gender;
  final String name;
  final int age;
  List<Appointment> appointments;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.gender,
    required this.name,
    required this.age,
    List<Appointment>? appointments,
  }) : appointments = appointments ?? [];

  // Factory constructor for create user obj
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
      age: json['age'] != null ? json['age'] as int : 0,
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
      'age': age,
    };
  }

  // find the upcoming appointments
  List<Appointment> getUpcomingAppointments() {
    return appointments
      .where((appointment) => appointment.isUpcoming())
      .toList();
  }

   // find the missed appointments
  List<Appointment> getMissedAppointments() {
      return appointments
      .where((appointment) => appointment.isMissed())
      .toList();
    }
  // find the cancelled appointments
  List<Appointment> getCancelledAppointments() {
    return appointments
      .where((appointment) => appointment.isCancelled())
      .toList();
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, age: $age, email: $email, role: ${role.toString().split('.').last}, gender: ${gender.toString().split('.').last})';
  }
}
